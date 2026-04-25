/// The configuration settings for an Amazon VPC that contains data sources for
/// your Grafana workspace to connect to.
///
/// Provided `securityGroupIds` and `subnetIds` must be part of the same VPC.
///
/// Connecting to a private VPC is not yet available in the Asia Pacific (Seoul)
/// Region (ap-northeast-2).
pub const VpcConfiguration = struct {
    /// The list of Amazon EC2 security group IDs attached to the Amazon VPC for
    /// your Grafana workspace to connect. Duplicates not allowed.
    security_group_ids: []const []const u8,

    /// The list of Amazon EC2 subnet IDs created in the Amazon VPC for your Grafana
    /// workspace to connect. Duplicates not allowed.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
