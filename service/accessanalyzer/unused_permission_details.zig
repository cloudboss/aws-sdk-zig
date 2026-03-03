const UnusedAction = @import("unused_action.zig").UnusedAction;

/// Contains information about an unused access finding for a permission. IAM
/// Access Analyzer charges for unused access analysis based on the number of
/// IAM roles and users analyzed per month. For more details on pricing, see
/// [IAM Access Analyzer
/// pricing](https://aws.amazon.com/iam/access-analyzer/pricing).
pub const UnusedPermissionDetails = struct {
    /// A list of unused actions for which the unused access finding was generated.
    actions: ?[]const UnusedAction = null,

    /// The time at which the permission was last accessed.
    last_accessed: ?i64 = null,

    /// The namespace of the Amazon Web Services service that contains the unused
    /// actions.
    service_namespace: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .last_accessed = "lastAccessed",
        .service_namespace = "serviceNamespace",
    };
};
