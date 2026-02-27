const AccessScope = @import("access_scope.zig").AccessScope;

/// An access policy association.
pub const AssociatedAccessPolicy = struct {
    /// The scope of the access policy.
    access_scope: ?AccessScope,

    /// The date and time the `AccessPolicy` was associated with an
    /// `AccessEntry`.
    associated_at: ?i64,

    /// The Unix epoch timestamp for the last modification to the object.
    modified_at: ?i64,

    /// The ARN of the `AccessPolicy`.
    policy_arn: ?[]const u8,

    pub const json_field_names = .{
        .access_scope = "accessScope",
        .associated_at = "associatedAt",
        .modified_at = "modifiedAt",
        .policy_arn = "policyArn",
    };
};
