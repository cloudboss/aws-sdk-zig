/// The hyper pod properties of a Amazon Web Services Glue properties patch.
pub const HyperPodPropertiesInput = struct {
    /// The cluster name the hyper pod properties.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
    };
};
