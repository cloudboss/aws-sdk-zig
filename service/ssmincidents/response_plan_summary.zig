/// Details of the response plan that are used when creating an incident.
pub const ResponsePlanSummary = struct {
    /// The Amazon Resource Name (ARN) of the response plan.
    arn: []const u8,

    /// The human readable name of the response plan. This can include spaces.
    display_name: ?[]const u8,

    /// The name of the response plan. This can't include spaces.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .display_name = "displayName",
        .name = "name",
    };
};
