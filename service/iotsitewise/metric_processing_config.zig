const ComputeLocation = @import("compute_location.zig").ComputeLocation;

/// The processing configuration for the given metric property.
/// You can configure metrics to be computed at the edge or in the Amazon Web
/// Services Cloud.
/// By default, metrics are forwarded to the cloud.
pub const MetricProcessingConfig = struct {
    /// The compute location for the given metric property.
    compute_location: ComputeLocation,

    pub const json_field_names = .{
        .compute_location = "computeLocation",
    };
};
