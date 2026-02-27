/// Information about a validator.
pub const Validator = struct {
    /// The S3 URI where the validation data is stored.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
