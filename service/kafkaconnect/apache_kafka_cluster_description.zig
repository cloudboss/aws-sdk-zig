const VpcDescription = @import("vpc_description.zig").VpcDescription;

/// The description of the Apache Kafka cluster to which the connector is
/// connected.
pub const ApacheKafkaClusterDescription = struct {
    /// The bootstrap servers of the cluster.
    bootstrap_servers: ?[]const u8 = null,

    /// Details of an Amazon VPC which has network connectivity to the Apache Kafka
    /// cluster.
    vpc: ?VpcDescription = null,

    pub const json_field_names = .{
        .bootstrap_servers = "bootstrapServers",
        .vpc = "vpc",
    };
};
