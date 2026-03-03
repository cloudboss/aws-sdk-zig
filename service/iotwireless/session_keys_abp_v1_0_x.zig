/// Session keys for ABP v1.1
pub const SessionKeysAbpV1_0_x = struct {
    /// The AppSKey value.
    app_s_key: ?[]const u8 = null,

    /// The NwkSKey value.
    nwk_s_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_s_key = "AppSKey",
        .nwk_s_key = "NwkSKey",
    };
};
