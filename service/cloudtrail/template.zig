/// Specifies the type of the aggregation templates in the aggregation
/// configuration. Valid values include API_ACTIVITY, RESOURCE_ACCESS and
/// USER_ACTIONS.
pub const Template = enum {
    api_activity,
    resource_access,
    user_actions,

    pub const json_field_names = .{
        .api_activity = "API_ACTIVITY",
        .resource_access = "RESOURCE_ACCESS",
        .user_actions = "USER_ACTIONS",
    };
};
