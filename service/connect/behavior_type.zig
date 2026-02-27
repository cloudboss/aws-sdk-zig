pub const BehaviorType = enum {
    route_current_channel_only,
    route_any_channel,

    pub const json_field_names = .{
        .route_current_channel_only = "ROUTE_CURRENT_CHANNEL_ONLY",
        .route_any_channel = "ROUTE_ANY_CHANNEL",
    };
};
