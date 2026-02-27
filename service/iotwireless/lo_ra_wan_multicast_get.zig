const DlClass = @import("dl_class.zig").DlClass;
const ParticipatingGatewaysMulticast = @import("participating_gateways_multicast.zig").ParticipatingGatewaysMulticast;
const SupportedRfRegion = @import("supported_rf_region.zig").SupportedRfRegion;

/// The LoRaWAN information that is to be returned from getting multicast group
/// information.
pub const LoRaWANMulticastGet = struct {
    dl_class: ?DlClass,

    number_of_devices_in_group: ?i32,

    number_of_devices_requested: ?i32,

    participating_gateways: ?ParticipatingGatewaysMulticast,

    rf_region: ?SupportedRfRegion,

    pub const json_field_names = .{
        .dl_class = "DlClass",
        .number_of_devices_in_group = "NumberOfDevicesInGroup",
        .number_of_devices_requested = "NumberOfDevicesRequested",
        .participating_gateways = "ParticipatingGateways",
        .rf_region = "RfRegion",
    };
};
