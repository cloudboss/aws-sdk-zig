const Subnet = @import("subnet.zig").Subnet;

/// Describes a subnet group in response to a request by the
/// `DescribeReplicationSubnetGroups` operation.
pub const ReplicationSubnetGroup = struct {
    /// Indicates whether the replication subnet group is read-only. When set to
    /// `true`,
    /// this subnet group is managed by DMS as part of a zero-ETL integration and
    /// cannot be modified
    /// or deleted directly. You can only modify or delete read-only subnet groups
    /// through their
    /// associated zero-ETL integration.
    is_read_only: ?bool = null,

    /// A description for the replication subnet group.
    replication_subnet_group_description: ?[]const u8 = null,

    /// The identifier of the replication instance subnet group.
    replication_subnet_group_identifier: ?[]const u8 = null,

    /// The status of the subnet group.
    subnet_group_status: ?[]const u8 = null,

    /// The subnets that are in the subnet group.
    subnets: ?[]const Subnet = null,

    /// The IP addressing protocol supported by the subnet group. This is used by a
    /// replication
    /// instance with values such as IPv4 only or Dual-stack that supports both IPv4
    /// and IPv6
    /// addressing. IPv6 only is not yet supported.
    supported_network_types: ?[]const []const u8 = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_read_only = "IsReadOnly",
        .replication_subnet_group_description = "ReplicationSubnetGroupDescription",
        .replication_subnet_group_identifier = "ReplicationSubnetGroupIdentifier",
        .subnet_group_status = "SubnetGroupStatus",
        .subnets = "Subnets",
        .supported_network_types = "SupportedNetworkTypes",
        .vpc_id = "VpcId",
    };
};
