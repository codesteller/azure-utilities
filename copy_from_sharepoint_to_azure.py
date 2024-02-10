from office365.runtime.auth.authentication_context import AuthenticationContext
from office365.sharepoint.client_context import ClientContext
from office365.sharepoint.files.file import File
from office365.sharepoint.files.folder import Folder

# SharePoint credentials
username = "pallab.maji@gahanai.com"
password = "Ir0|\|m@n"
site_url = "https://gahanaiprivatelimited287.sharepoint.com/sites/Datasets"
library_name = "EyeGlassDataset"

# Connect to SharePoint site

ctx_auth = AuthenticationContext(url=site_url)
if ctx_auth.acquire_token_for_user(username, password):
    ctx = ClientContext(site_url, ctx_auth)
    web = ctx.web
    ctx.load(web)
    ctx.execute_query()

    # Get all files and folders in the document library
    library = web.lists.get_by_title(library_name)
    folders = library.root_folder.folders
    ctx.load(folders)
    ctx.execute_query()

    # Download files
    for folder in folders:
        files = folder.files
        ctx.load(files)
        ctx.execute_query()
        for file in files:
            file.download(file.properties["Name"])

    # Download folders recursively
    def download_folder(folder):
        subfolders = folder.folders
        ctx.load(subfolders)
        ctx.execute_query()
        for subfolder in subfolders:
            subfolder.download(subfolder.properties["Name"])
            download_folder(subfolder)

    download_folder(library.root_folder)

    # Disconnect from SharePoint site
    ctx_auth.logout()
else:
    print("Failed to authenticate.")
