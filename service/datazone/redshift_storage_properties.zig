/// The Amazon Redshift storage properties.
pub const RedshiftStorageProperties = union(enum) {
    /// The cluster name in the Amazon Redshift storage properties.
    cluster_name: ?[]const u8,
    /// The workgroup name in the Amazon Redshift storage properties.
    workgroup_name: ?[]const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .workgroup_name = "workgroupName",
    };
};
