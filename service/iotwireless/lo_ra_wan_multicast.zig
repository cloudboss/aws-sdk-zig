const DefaultSessionParametersMulticast = @import("default_session_parameters_multicast.zig").DefaultSessionParametersMulticast;
const DlClass = @import("dl_class.zig").DlClass;
const ParticipatingGatewaysMulticast = @import("participating_gateways_multicast.zig").ParticipatingGatewaysMulticast;
const SupportedRfRegion = @import("supported_rf_region.zig").SupportedRfRegion;

/// The LoRaWAN information that is to be used with the multicast group.
pub const LoRaWANMulticast = struct {
    /// The default session parameters for the multicast group.
    default_session_parameters: ?DefaultSessionParametersMulticast = null,

    dl_class: ?DlClass = null,

    participating_gateways: ?ParticipatingGatewaysMulticast = null,

    rf_region: ?SupportedRfRegion = null,

    pub const json_field_names = .{
        .default_session_parameters = "DefaultSessionParameters",
        .dl_class = "DlClass",
        .participating_gateways = "ParticipatingGateways",
        .rf_region = "RfRegion",
    };
};
