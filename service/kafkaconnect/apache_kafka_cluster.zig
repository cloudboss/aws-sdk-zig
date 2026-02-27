const Vpc = @import("vpc.zig").Vpc;

/// The details of the Apache Kafka cluster to which the connector is connected.
pub const ApacheKafkaCluster = struct {
    /// The bootstrap servers of the cluster.
    bootstrap_servers: []const u8,

    /// Details of an Amazon VPC which has network connectivity to the Apache Kafka
    /// cluster.
    vpc: Vpc,

    pub const json_field_names = .{
        .bootstrap_servers = "bootstrapServers",
        .vpc = "vpc",
    };
};
