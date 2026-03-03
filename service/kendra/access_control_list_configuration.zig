/// Access Control List files for the documents in a data source. For the format
/// of the
/// file, see [Access control
/// for S3 data
/// sources](https://docs.aws.amazon.com/kendra/latest/dg/s3-acl.html).
pub const AccessControlListConfiguration = struct {
    /// Path to the Amazon S3 bucket that contains the ACL files.
    key_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_path = "KeyPath",
    };
};
