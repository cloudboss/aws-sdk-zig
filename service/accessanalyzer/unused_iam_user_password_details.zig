/// Contains information about an unused access finding for an IAM user
/// password. IAM Access Analyzer charges for unused access analysis based on
/// the number of IAM roles and users analyzed per month. For more details on
/// pricing, see [IAM Access Analyzer
/// pricing](https://aws.amazon.com/iam/access-analyzer/pricing).
pub const UnusedIamUserPasswordDetails = struct {
    /// The time at which the password was last accessed.
    last_accessed: ?i64 = null,

    pub const json_field_names = .{
        .last_accessed = "lastAccessed",
    };
};
