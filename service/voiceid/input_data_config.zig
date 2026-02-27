/// The configuration containing input file information for a batch job.
pub const InputDataConfig = struct {
    /// The S3 location for the input manifest file that contains the list of
    /// individual
    /// enrollment or registration job requests.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
