/// The source of the experiment.
pub const ExperimentSource = struct {
    /// The Amazon Resource Name (ARN) of the source.
    source_arn: []const u8,

    /// The source type.
    source_type: ?[]const u8,

    pub const json_field_names = .{
        .source_arn = "SourceArn",
        .source_type = "SourceType",
    };
};
