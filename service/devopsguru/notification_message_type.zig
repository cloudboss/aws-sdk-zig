pub const NotificationMessageType = enum {
    new_insight,
    closed_insight,
    new_association,
    severity_upgraded,
    new_recommendation,

    pub const json_field_names = .{
        .new_insight = "NEW_INSIGHT",
        .closed_insight = "CLOSED_INSIGHT",
        .new_association = "NEW_ASSOCIATION",
        .severity_upgraded = "SEVERITY_UPGRADED",
        .new_recommendation = "NEW_RECOMMENDATION",
    };
};
