/// The details of the Amazon Redshift cluster storage.
pub const RedshiftClusterStorage = struct {
    /// The name of an Amazon Redshift cluster.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
    };
};
