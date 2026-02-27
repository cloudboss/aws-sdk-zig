/// The LoRaWAN information returned from getting a FUOTA task.
pub const LoRaWANFuotaTaskGetInfo = struct {
    rf_region: ?[]const u8,

    start_time: ?i64,

    pub const json_field_names = .{
        .rf_region = "RfRegion",
        .start_time = "StartTime",
    };
};
