# Azure Utilities
This repository houses scripts that makes development on MS Azure painless

## Prerequisites
1. Azure VM
2. Azure CLI

## Usage
1. Clone the repository
2. Make appropriate changes to the Config Files
3. Run the scripts

```
git clone https://github.com/g-codesteller/azure-utilities.git

vi azure-utilities/config.sh # Make changes to the config file with right Account Name and Key

bash azure-utilities/mount_storage_account.sh
```

To unmount the storage account, run the following command
```
blobfuse2 unmount ~/datasets
```



