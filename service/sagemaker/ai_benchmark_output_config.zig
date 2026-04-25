/// The output configuration for an AI benchmark job.
pub const AIBenchmarkOutputConfig = struct {
    /// The Amazon S3 URI where benchmark results are stored.
    s3_output_location: []const u8,

    pub const json_field_names = .{
        .s3_output_location = "S3OutputLocation",
    };
};
