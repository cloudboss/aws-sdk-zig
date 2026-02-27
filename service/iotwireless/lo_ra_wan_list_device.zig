/// LoRaWAN object for list functions.
pub const LoRaWANListDevice = struct {
    /// The DevEUI value.
    dev_eui: ?[]const u8,

    pub const json_field_names = .{
        .dev_eui = "DevEui",
    };
};
