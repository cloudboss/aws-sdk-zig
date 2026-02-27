pub const eventTypeCategory = enum {
    issue,
    account_notification,
    scheduled_change,
    investigation,

    pub const json_field_names = .{
        .issue = "ISSUE",
        .account_notification = "ACCOUNT_NOTIFICATION",
        .scheduled_change = "SCHEDULED_CHANGE",
        .investigation = "INVESTIGATION",
    };
};
