const Replica = @import("replica.zig").Replica;

/// Represents the properties of a global table.
pub const GlobalTable = struct {
    /// The global table name.
    global_table_name: ?[]const u8 = null,

    /// The Regions where the global table has replicas.
    replication_group: ?[]const Replica = null,

    pub const json_field_names = .{
        .global_table_name = "GlobalTableName",
        .replication_group = "ReplicationGroup",
    };
};
