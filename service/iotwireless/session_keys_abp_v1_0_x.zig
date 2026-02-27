/// Session keys for ABP v1.1
pub const SessionKeysAbpV1_0_x = struct {
    /// The AppSKey value.
    app_s_key: ?[]const u8,

    /// The NwkSKey value.
    nwk_s_key: ?[]const u8,

    pub const json_field_names = .{
        .app_s_key = "AppSKey",
        .nwk_s_key = "NwkSKey",
    };
};
