pub const AutomationEventFilterName = enum {
    account_id,
    resource_type,
    event_type,
    event_status,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .resource_type = "RESOURCE_TYPE",
        .event_type = "EVENT_TYPE",
        .event_status = "EVENT_STATUS",
    };
};
