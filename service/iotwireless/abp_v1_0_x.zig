const SessionKeysAbpV1_0_x = @import("session_keys_abp_v1_0_x.zig").SessionKeysAbpV1_0_x;

/// ABP device object for LoRaWAN specification v1.0.x
pub const AbpV1_0_x = struct {
    /// The DevAddr value.
    dev_addr: ?[]const u8,

    /// The FCnt init value.
    f_cnt_start: ?i32,

    /// Session keys for ABP v1.0.x
    session_keys: ?SessionKeysAbpV1_0_x,

    pub const json_field_names = .{
        .dev_addr = "DevAddr",
        .f_cnt_start = "FCntStart",
        .session_keys = "SessionKeys",
    };
};
