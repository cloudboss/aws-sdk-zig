/// OTAA device object for v1.0.x
pub const OtaaV1_0_x = struct {
    /// The AppEUI value. You specify this value when using LoRaWAN versions v1.0.2
    /// or
    /// v1.0.3.
    app_eui: ?[]const u8,

    /// The AppKey value.
    app_key: ?[]const u8,

    /// The GenAppKey value.
    gen_app_key: ?[]const u8,

    /// The JoinEUI value. You specify this value instead of the AppEUI when using
    /// LoRaWAN
    /// version v1.0.4.
    join_eui: ?[]const u8,

    pub const json_field_names = .{
        .app_eui = "AppEui",
        .app_key = "AppKey",
        .gen_app_key = "GenAppKey",
        .join_eui = "JoinEui",
    };
};
