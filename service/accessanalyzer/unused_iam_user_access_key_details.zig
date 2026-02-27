/// Contains information about an unused access finding for an IAM user access
/// key. IAM Access Analyzer charges for unused access analysis based on the
/// number of IAM roles and users analyzed per month. For more details on
/// pricing, see [IAM Access Analyzer
/// pricing](https://aws.amazon.com/iam/access-analyzer/pricing).
pub const UnusedIamUserAccessKeyDetails = struct {
    /// The ID of the access key for which the unused access finding was generated.
    access_key_id: []const u8,

    /// The time at which the access key was last accessed.
    last_accessed: ?i64,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .last_accessed = "lastAccessed",
    };
};
