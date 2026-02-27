pub const TargetStore = enum {
    online_store,
    offline_store,

    pub const json_field_names = .{
        .online_store = "ONLINE_STORE",
        .offline_store = "OFFLINE_STORE",
    };
};
