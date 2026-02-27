/// The shared access signature (SAS) configuration that allows DataSync to
/// access your Microsoft Azure Blob Storage.
///
/// For more information, see [SAS
/// tokens](https://docs.aws.amazon.com/datasync/latest/userguide/creating-azure-blob-location.html#azure-blob-sas-tokens) for accessing your Azure Blob Storage.
pub const AzureBlobSasConfiguration = struct {
    /// Specifies a SAS token that provides permissions to access your Azure Blob
    /// Storage.
    ///
    /// The token is part of the SAS URI string that comes after the storage
    /// resource URI and a
    /// question mark. A token looks something like this:
    ///
    /// `sp=r&st=2023-12-20T14:54:52Z&se=2023-12-20T22:54:52Z&spr=https&sv=2021-06-08&sr=c&sig=aBBKDWQvyuVcTPH9EBp%2FXTI9E%2F%2Fmq171%2BZU178wcwqU%3D`
    token: []const u8,

    pub const json_field_names = .{
        .token = "Token",
    };
};
