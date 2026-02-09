const Replica = @import("replica.zig").Replica;

/// Represents the properties of a global table.
pub const GlobalTable = struct {
    /// The global table name.
    global_table_name: ?[]const u8,

    /// The Regions where the global table has replicas.
    replication_group: ?[]const Replica,
};
