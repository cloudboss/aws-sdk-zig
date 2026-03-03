/// The source of the trial.
pub const TrialSource = struct {
    /// The Amazon Resource Name (ARN) of the source.
    source_arn: []const u8,

    /// The source job type.
    source_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_arn = "SourceArn",
        .source_type = "SourceType",
    };
};
