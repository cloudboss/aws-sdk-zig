const TagConflictResolutionStrategy = @import("tag_conflict_resolution_strategy.zig").TagConflictResolutionStrategy;

/// Specifies configuration for propagating resource tags from source log groups
/// to centralized destination log groups. The service uses a customer-managed
/// IAM role in the destination account to add, update, and remove tags on
/// destination log groups.
pub const TagPropagationConfiguration = struct {
    /// The ARN of a customer-managed IAM role in the destination account. The
    /// service assumes this role to propagate tags to destination log groups. You
    /// must have `iam:PassRole` permission on this role.
    destination_role_arn: []const u8,

    /// The strategy for resolving conflicts when a tag key exists on both the
    /// source and destination log groups. If not specified, defaults to
    /// `UPDATE_SYNC`.
    ///
    /// * `ADD_ONLY` – Only adds new tags from the source without modifying existing
    ///   destination tags.
    /// * `UPDATE_SYNC` – Adds new tags and updates existing tags from the source.
    ///   Does not remove destination tags that are absent from the source.
    /// * `IN_SYNC` – Keeps destination tags fully synchronized with source tags,
    ///   including removing destination tags that do not exist on the source.
    tag_conflict_resolution_strategy: ?TagConflictResolutionStrategy = null,

    pub const json_field_names = .{
        .destination_role_arn = "DestinationRoleArn",
        .tag_conflict_resolution_strategy = "TagConflictResolutionStrategy",
    };
};
