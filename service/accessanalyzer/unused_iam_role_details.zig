/// Contains information about an unused access finding for an IAM role. IAM
/// Access Analyzer charges for unused access analysis based on the number of
/// IAM roles and users analyzed per month. For more details on pricing, see
/// [IAM Access Analyzer
/// pricing](https://aws.amazon.com/iam/access-analyzer/pricing).
pub const UnusedIamRoleDetails = struct {
    /// The time at which the role was last accessed.
    last_accessed: ?i64,

    pub const json_field_names = .{
        .last_accessed = "lastAccessed",
    };
};
