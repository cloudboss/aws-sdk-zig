const ParticipatingGateways = @import("participating_gateways.zig").ParticipatingGateways;

/// LoRaWAN router info.
pub const LoRaWANSendDataToDevice = struct {
    f_port: ?i32 = null,

    /// Choose the gateways that you want to use for the downlink data traffic when
    /// the
    /// wireless device is running in class B or class C mode.
    participating_gateways: ?ParticipatingGateways = null,

    pub const json_field_names = .{
        .f_port = "FPort",
        .participating_gateways = "ParticipatingGateways",
    };
};
