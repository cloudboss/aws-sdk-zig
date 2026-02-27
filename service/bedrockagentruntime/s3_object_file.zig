/// Contains details of the s3 object where the source file is located.
pub const S3ObjectFile = struct {
    /// The uri of the s3 object.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
