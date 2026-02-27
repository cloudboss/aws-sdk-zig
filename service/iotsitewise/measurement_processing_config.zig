const ForwardingConfig = @import("forwarding_config.zig").ForwardingConfig;

/// The processing configuration for the given measurement property.
/// You can configure measurements to be kept at the edge or forwarded to the
/// Amazon Web Services Cloud.
/// By default, measurements are forwarded to the cloud.
pub const MeasurementProcessingConfig = struct {
    /// The forwarding configuration for the given measurement property.
    forwarding_config: ForwardingConfig,

    pub const json_field_names = .{
        .forwarding_config = "forwardingConfig",
    };
};
