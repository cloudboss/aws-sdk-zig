pub const EventSourceName = enum {
    user_notification,
    user_auth_events,

    pub const json_field_names = .{
        .user_notification = "USER_NOTIFICATION",
        .user_auth_events = "USER_AUTH_EVENTS",
    };
};
