/// OTAA device object for v1.1
pub const OtaaV1_1 = struct {
    /// The AppKey value.
    app_key: ?[]const u8 = null,

    /// The JoinEUI value.
    join_eui: ?[]const u8 = null,

    /// The NwkKey value.
    nwk_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_key = "AppKey",
        .join_eui = "JoinEui",
        .nwk_key = "NwkKey",
    };
};
