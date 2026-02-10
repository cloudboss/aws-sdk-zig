const ReplicationRule = @import("replication_rule.zig").ReplicationRule;

/// A container for replication rules. You can add up to 1,000 rules. The
/// maximum size of a replication
/// configuration is 2 MB.
pub const ReplicationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that Amazon S3 assumes when replicating
    /// objects. For more information, see [How to Set Up
    /// Replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-how-setup.html) in the
    /// *Amazon S3 User Guide*.
    role: []const u8,

    /// A container for one or more replication rules. A replication configuration
    /// must have at least one
    /// rule and can contain a maximum of 1,000 rules.
    rules: []const ReplicationRule,
};
