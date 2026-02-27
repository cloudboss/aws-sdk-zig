/// The Amazon Resource Name (ARN) and job type of the source of a trial
/// component.
pub const TrialComponentSource = struct {
    /// The source Amazon Resource Name (ARN).
    source_arn: []const u8,

    /// The source job type.
    source_type: ?[]const u8,

    pub const json_field_names = .{
        .source_arn = "SourceArn",
        .source_type = "SourceType",
    };
};
