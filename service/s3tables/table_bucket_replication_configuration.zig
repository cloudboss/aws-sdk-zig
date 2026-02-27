const TableBucketReplicationRule = @import("table_bucket_replication_rule.zig").TableBucketReplicationRule;

/// The replication configuration for a table bucket. This configuration defines
/// how tables in the source bucket are replicated to destination table buckets,
/// including the IAM role used for replication.
pub const TableBucketReplicationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that S3 Tables assumes to
    /// replicate tables on your behalf.
    role: []const u8,

    /// An array of replication rules that define which tables to replicate and
    /// where to replicate them.
    rules: []const TableBucketReplicationRule,

    pub const json_field_names = .{
        .role = "role",
        .rules = "rules",
    };
};
