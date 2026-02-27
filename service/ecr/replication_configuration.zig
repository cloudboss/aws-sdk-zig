const ReplicationRule = @import("replication_rule.zig").ReplicationRule;

/// The replication configuration for a registry.
pub const ReplicationConfiguration = struct {
    /// An array of objects representing the replication destinations and repository
    /// filters
    /// for a replication configuration.
    rules: []const ReplicationRule,

    pub const json_field_names = .{
        .rules = "rules",
    };
};
