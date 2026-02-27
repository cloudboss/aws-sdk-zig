/// The status of the elastic IP (EIP) address for an Amazon Redshift cluster.
pub const AwsRedshiftClusterElasticIpStatus = struct {
    /// The elastic IP address for the cluster.
    elastic_ip: ?[]const u8,

    /// The status of the elastic IP address.
    status: ?[]const u8,

    pub const json_field_names = .{
        .elastic_ip = "ElasticIp",
        .status = "Status",
    };
};
