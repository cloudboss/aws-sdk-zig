const ReplicationRule = @import("replication_rule.zig").ReplicationRule;

/// A container for one or more replication rules. A replication configuration
/// must have at
/// least one rule and you can add up to 100 rules. The maximum size of a
/// replication
/// configuration is 128 KB.
pub const ReplicationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that S3 on Outposts assumes
    /// when replicating objects. For information about S3 replication on Outposts
    /// configuration,
    /// see [Setting up
    /// replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/outposts-replication-how-setup.html) in the *Amazon S3 User Guide*.
    role: []const u8,

    /// A container for one or more replication rules. A replication configuration
    /// must have at
    /// least one rule and can contain an array of 100 rules at the most.
    rules: []const ReplicationRule,
};
