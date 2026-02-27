const ListNotificationRulesFilterName = @import("list_notification_rules_filter_name.zig").ListNotificationRulesFilterName;

/// Information about a filter to apply to the list of returned notification
/// rules. You can
/// filter by event type, owner, resource, or target.
pub const ListNotificationRulesFilter = struct {
    /// The name of the attribute you want to use to filter the returned
    /// notification rules.
    name: ListNotificationRulesFilterName,

    /// The value of the attribute you want to use to filter the returned
    /// notification rules. For example, if you specify filtering by *RESOURCE*
    /// in Name, you might specify the ARN of a pipeline in CodePipeline for the
    /// value.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
