const DlClass = @import("dl_class.zig").DlClass;
const ParticipatingGatewaysMulticast = @import("participating_gateways_multicast.zig").ParticipatingGatewaysMulticast;
const SupportedRfRegion = @import("supported_rf_region.zig").SupportedRfRegion;

/// The LoRaWAN information that is to be used with the multicast group.
pub const LoRaWANMulticast = struct {
    dl_class: ?DlClass,

    participating_gateways: ?ParticipatingGatewaysMulticast,

    rf_region: ?SupportedRfRegion,

    pub const json_field_names = .{
        .dl_class = "DlClass",
        .participating_gateways = "ParticipatingGateways",
        .rf_region = "RfRegion",
    };
};
