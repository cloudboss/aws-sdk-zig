const ComputeLocation = @import("compute_location.zig").ComputeLocation;
const ForwardingConfig = @import("forwarding_config.zig").ForwardingConfig;

/// The processing configuration for the given transform property.
/// You can configure transforms to be kept at the edge or forwarded to the
/// Amazon Web Services Cloud.
/// You can also configure transforms to be computed at the edge or in the
/// cloud.
pub const TransformProcessingConfig = struct {
    /// The compute location for the given transform property.
    compute_location: ComputeLocation,

    forwarding_config: ?ForwardingConfig = null,

    pub const json_field_names = .{
        .compute_location = "computeLocation",
        .forwarding_config = "forwardingConfig",
    };
};
