/// Returns a summary of information about a `Baseline` object.
pub const BaselineSummary = struct {
    /// The full ARN of a Baseline.
    arn: []const u8,

    /// A summary description of a Baseline.
    description: ?[]const u8,

    /// The human-readable name of a Baseline.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .name = "name",
    };
};
