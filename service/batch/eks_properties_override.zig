const EksPodPropertiesOverride = @import("eks_pod_properties_override.zig").EksPodPropertiesOverride;

/// An object that contains overrides for the Kubernetes resources of a job.
pub const EksPropertiesOverride = struct {
    /// The overrides for the Kubernetes pod resources of a job.
    pod_properties: ?EksPodPropertiesOverride = null,

    pub const json_field_names = .{
        .pod_properties = "podProperties",
    };
};
