const SupportedRfRegion = @import("supported_rf_region.zig").SupportedRfRegion;

/// The LoRaWAN information used with a FUOTA task.
pub const LoRaWANFuotaTask = struct {
    rf_region: ?SupportedRfRegion,

    pub const json_field_names = .{
        .rf_region = "RfRegion",
    };
};
