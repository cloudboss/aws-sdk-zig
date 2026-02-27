/// Describes the status of the elastic IP (EIP) address.
pub const ElasticIpStatus = struct {
    /// The elastic IP (EIP) address for the cluster.
    elastic_ip: ?[]const u8,

    /// The status of the elastic IP (EIP) address.
    status: ?[]const u8,
};
