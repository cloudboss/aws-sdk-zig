/// Contains information about an unused access finding for an action. IAM
/// Access Analyzer charges for unused access analysis based on the number of
/// IAM roles and users analyzed per month. For more details on pricing, see
/// [IAM Access Analyzer
/// pricing](https://aws.amazon.com/iam/access-analyzer/pricing).
pub const UnusedAction = struct {
    /// The action for which the unused access finding was generated.
    action: []const u8,

    /// The time at which the action was last accessed.
    last_accessed: ?i64,

    pub const json_field_names = .{
        .action = "action",
        .last_accessed = "lastAccessed",
    };
};
