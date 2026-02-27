const EksPodProperties = @import("eks_pod_properties.zig").EksPodProperties;

/// An object that contains the properties for the Kubernetes resources of a
/// job.
pub const EksProperties = struct {
    /// The properties for the Kubernetes pod resources of a job.
    pod_properties: ?EksPodProperties,

    pub const json_field_names = .{
        .pod_properties = "podProperties",
    };
};
