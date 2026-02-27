const RetentionType = @import("retention_type.zig").RetentionType;

/// The retention policy for data stored on an Amazon Elastic File System
/// volume.
pub const RetentionPolicy = struct {
    /// The default is `Retain`, which specifies to keep the data stored on the
    /// Amazon EFS volume.
    ///
    /// Specify `Delete` to delete the data stored on the Amazon EFS volume.
    home_efs_file_system: ?RetentionType,

    pub const json_field_names = .{
        .home_efs_file_system = "HomeEfsFileSystem",
    };
};
