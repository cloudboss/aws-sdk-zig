pub const HistoryItemType = enum {
    configuration_update,
    state_update,
    action,
    alarm_contributor_state_update,
    alarm_contributor_action,

    pub const json_field_names = .{
        .configuration_update = "ConfigurationUpdate",
        .state_update = "StateUpdate",
        .action = "Action",
        .alarm_contributor_state_update = "AlarmContributorStateUpdate",
        .alarm_contributor_action = "AlarmContributorAction",
    };
};
