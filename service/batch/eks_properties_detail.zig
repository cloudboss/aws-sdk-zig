const EksPodPropertiesDetail = @import("eks_pod_properties_detail.zig").EksPodPropertiesDetail;

/// An object that contains the details for the Kubernetes resources of a job.
pub const EksPropertiesDetail = struct {
    /// The properties for the Kubernetes pod resources of a job.
    pod_properties: ?EksPodPropertiesDetail,

    pub const json_field_names = .{
        .pod_properties = "podProperties",
    };
};
