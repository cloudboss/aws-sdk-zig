/// Information about the protected S3 bucket resource.
pub const UpdateS3BucketResource = struct {
    /// Information about the specified object prefixes. The S3 object will be
    /// scanned only
    /// if it belongs to any of the specified object prefixes.
    object_prefixes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .object_prefixes = "ObjectPrefixes",
    };
};
