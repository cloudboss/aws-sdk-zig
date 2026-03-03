const InsightsConfiguration = @import("insights_configuration.zig").InsightsConfiguration;

/// Details and metadata for a group.
pub const Group = struct {
    /// The filter expression defining the parameters to include traces.
    filter_expression: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the group generated based on the
    /// GroupName.
    group_arn: ?[]const u8 = null,

    /// The unique case-sensitive name of the group.
    group_name: ?[]const u8 = null,

    /// The structure containing configurations related to insights.
    ///
    /// * The InsightsEnabled boolean can be set to true to enable insights for the
    /// group or false to disable insights for the group.
    ///
    /// * The NotificationsEnabled boolean can be set to true to enable insights
    /// notifications through Amazon EventBridge for the group.
    insights_configuration: ?InsightsConfiguration = null,

    pub const json_field_names = .{
        .filter_expression = "FilterExpression",
        .group_arn = "GroupARN",
        .group_name = "GroupName",
        .insights_configuration = "InsightsConfiguration",
    };
};
