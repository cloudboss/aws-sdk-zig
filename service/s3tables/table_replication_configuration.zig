const TableReplicationRule = @import("table_replication_rule.zig").TableReplicationRule;

/// The replication configuration for an individual table. This configuration
/// defines how the table is replicated to destination tables.
pub const TableReplicationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that S3 Tables assumes to
    /// replicate the table on your behalf.
    role: []const u8,

    /// An array of replication rules that define where this table should be
    /// replicated.
    rules: []const TableReplicationRule,

    pub const json_field_names = .{
        .role = "role",
        .rules = "rules",
    };
};
