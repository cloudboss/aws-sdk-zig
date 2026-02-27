/// The FSx for ONTAP UNIX file system user that is used for authorizing all
/// file access requests that are made using the S3 access point.
pub const OntapUnixFileSystemUser = struct {
    /// The name of the UNIX user. The name can be up to 256 characters long.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
