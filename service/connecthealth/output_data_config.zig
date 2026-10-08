/// Configuration details for insights output.
pub const OutputDataConfig = struct {
    /// S3 URI where the insights output will be stored.
    s_3_output_path: []const u8,

    pub const json_field_names = .{
        .s_3_output_path = "s3OutputPath",
    };
};
