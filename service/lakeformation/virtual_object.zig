/// An object that defines an Amazon S3 object to be deleted if a transaction
/// cancels, provided that
/// `VirtualPut` was called before writing the object.
pub const VirtualObject = struct {
    /// The ETag of the Amazon S3 object.
    e_tag: ?[]const u8,

    /// The path to the Amazon S3 object. Must start with s3://
    uri: []const u8,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .uri = "Uri",
    };
};
