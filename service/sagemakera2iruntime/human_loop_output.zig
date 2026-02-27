/// Information about where the human output will be stored.
pub const HumanLoopOutput = struct {
    /// The location of the Amazon S3 object where Amazon Augmented AI stores your
    /// human loop output.
    output_s3_uri: []const u8,

    pub const json_field_names = .{
        .output_s3_uri = "OutputS3Uri",
    };
};
