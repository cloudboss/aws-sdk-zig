/// The Microsoft Active Directory attributes of the Amazon FSx for Windows File
/// Server file system.
pub const ActiveDirectoryBackupAttributes = struct {
    /// The ID of the Amazon Web Services Managed Microsoft Active Directory
    /// instance to which the file system is joined.
    active_directory_id: ?[]const u8,

    /// The fully qualified domain name of the self-managed Active Directory
    /// directory.
    domain_name: ?[]const u8,

    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .active_directory_id = "ActiveDirectoryId",
        .domain_name = "DomainName",
        .resource_arn = "ResourceARN",
    };
};
