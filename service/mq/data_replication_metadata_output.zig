const DataReplicationCounterpart = @import("data_replication_counterpart.zig").DataReplicationCounterpart;

/// The replication details of the data replication-enabled broker. Only
/// returned if dataReplicationMode or pendingDataReplicationMode is set to
/// CRDR.
pub const DataReplicationMetadataOutput = struct {
    /// Describes the replica/primary broker. Only returned if this broker is
    /// currently set as a primary or replica in the broker's dataReplicationRole
    /// property.
    data_replication_counterpart: ?DataReplicationCounterpart = null,

    /// Defines the role of this broker in a data replication pair. When a replica
    /// broker is promoted to primary, this role is interchanged.
    data_replication_role: []const u8,

    pub const json_field_names = .{
        .data_replication_counterpart = "DataReplicationCounterpart",
        .data_replication_role = "DataReplicationRole",
    };
};
