const SessionKeysAbpV1_1 = @import("session_keys_abp_v1_1.zig").SessionKeysAbpV1_1;

/// ABP device object for LoRaWAN specification v1.1
pub const AbpV1_1 = struct {
    /// The DevAddr value.
    dev_addr: ?[]const u8 = null,

    /// The FCnt init value.
    f_cnt_start: ?i32 = null,

    /// Session keys for ABP v1.1
    session_keys: ?SessionKeysAbpV1_1 = null,

    pub const json_field_names = .{
        .dev_addr = "DevAddr",
        .f_cnt_start = "FCntStart",
        .session_keys = "SessionKeys",
    };
};
