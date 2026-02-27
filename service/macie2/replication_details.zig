/// Provides information about settings that define whether one or more objects
/// in an S3 bucket are replicated to S3 buckets for other Amazon Web Services
/// accounts and, if so, which accounts.
pub const ReplicationDetails = struct {
    /// Specifies whether the bucket is configured to replicate one or more objects
    /// to any destination.
    replicated: ?bool,

    /// Specifies whether the bucket is configured to replicate one or more objects
    /// to a bucket for an Amazon Web Services account that isn't part of your
    /// Amazon Macie organization. An *Amazon Macie organization* is a set of Macie
    /// accounts that are centrally managed as a group of related accounts through
    /// Organizations or by Macie invitation.
    replicated_externally: ?bool,

    /// An array of Amazon Web Services account IDs, one for each Amazon Web
    /// Services account that owns a bucket that the bucket is configured to
    /// replicate one or more objects to.
    replication_accounts: ?[]const []const u8,

    pub const json_field_names = .{
        .replicated = "replicated",
        .replicated_externally = "replicatedExternally",
        .replication_accounts = "replicationAccounts",
    };
};
