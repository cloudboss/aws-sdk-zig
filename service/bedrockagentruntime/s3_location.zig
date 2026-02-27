/// Information about the Amazon S3 bucket where the image is stored.
pub const S3Location = struct {
    /// The path to the Amazon S3 bucket where the image is stored.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
