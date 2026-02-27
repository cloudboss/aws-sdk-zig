const SessionKeysAbpV1_1 = @import("session_keys_abp_v1_1.zig").SessionKeysAbpV1_1;

/// ABP device object for LoRaWAN specification v1.1
pub const AbpV1_1 = struct {
    /// The DevAddr value.
    dev_addr: ?[]const u8,

    /// The FCnt init value.
    f_cnt_start: ?i32,

    /// Session keys for ABP v1.1
    session_keys: ?SessionKeysAbpV1_1,

    pub const json_field_names = .{
        .dev_addr = "DevAddr",
        .f_cnt_start = "FCntStart",
        .session_keys = "SessionKeys",
    };
};
