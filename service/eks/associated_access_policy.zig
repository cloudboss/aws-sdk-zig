const AccessScope = @import("access_scope.zig").AccessScope;

/// An access policy association.
pub const AssociatedAccessPolicy = struct {
    /// The scope of the access policy.
    access_scope: ?AccessScope = null,

    /// The date and time the `AccessPolicy` was associated with an
    /// `AccessEntry`.
    associated_at: ?i64 = null,

    /// The Unix epoch timestamp for the last modification to the object.
    modified_at: ?i64 = null,

    /// The ARN of the `AccessPolicy`.
    policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_scope = "accessScope",
        .associated_at = "associatedAt",
        .modified_at = "modifiedAt",
        .policy_arn = "policyArn",
    };
};
