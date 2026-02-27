/// The FSx for ONTAP Windows file system user that is used for authorizing all
/// file access requests that are made using the S3 access point.
pub const OntapWindowsFileSystemUser = struct {
    /// The name of the Windows user. The name can be up to 256 characters long and
    /// supports Active Directory users.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
