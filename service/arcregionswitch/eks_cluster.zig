/// The Amazon Web Services EKS cluster execution block configuration.
pub const EksCluster = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Web Services EKS cluster.
    cluster_arn: []const u8,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
    };
};
