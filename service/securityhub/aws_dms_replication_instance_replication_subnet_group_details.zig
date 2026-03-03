/// Provides details about the replication subnet group.
pub const AwsDmsReplicationInstanceReplicationSubnetGroupDetails = struct {
    /// The identifier of the replication subnet group.
    replication_subnet_group_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .replication_subnet_group_identifier = "ReplicationSubnetGroupIdentifier",
    };
};
