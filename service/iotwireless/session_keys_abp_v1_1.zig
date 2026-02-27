/// Session keys for ABP v1.1
pub const SessionKeysAbpV1_1 = struct {
    /// The AppSKey value.
    app_s_key: ?[]const u8,

    /// The FNwkSIntKey value.
    f_nwk_s_int_key: ?[]const u8,

    /// The NwkSEncKey value.
    nwk_s_enc_key: ?[]const u8,

    /// The SNwkSIntKey value.
    s_nwk_s_int_key: ?[]const u8,

    pub const json_field_names = .{
        .app_s_key = "AppSKey",
        .f_nwk_s_int_key = "FNwkSIntKey",
        .nwk_s_enc_key = "NwkSEncKey",
        .s_nwk_s_int_key = "SNwkSIntKey",
    };
};
