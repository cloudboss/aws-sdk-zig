const SubscriptionGrantCreationMode = @import("subscription_grant_creation_mode.zig").SubscriptionGrantCreationMode;
const SubscriptionTargetForm = @import("subscription_target_form.zig").SubscriptionTargetForm;

/// The details of the subscription target.
pub const SubscriptionTargetSummary = struct {
    /// The asset types included in the subscription target.
    applicable_asset_types: []const []const u8,

    /// The authorized principals included in the subscription target.
    authorized_principals: []const []const u8,

    /// The timestamp of when the subscription target was created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription target.
    created_by: []const u8,

    /// The identifier of the Amazon DataZone domain in which the subscription
    /// target exists.
    domain_id: []const u8,

    /// The identifier of the environment of the subscription target.
    environment_id: []const u8,

    /// The identifier of the subscription target.
    id: []const u8,

    /// The manage access role specified in the subscription target.
    manage_access_role: ?[]const u8,

    /// The name of the subscription target.
    name: []const u8,

    /// The identifier of the project specified in the subscription target.
    project_id: []const u8,

    /// The provider of the subscription target.
    provider: []const u8,

    /// Determines the subscription grant creation mode for this target, defining if
    /// grants are auto-created upon subscription approval or managed manually.
    subscription_grant_creation_mode: ?SubscriptionGrantCreationMode,

    /// The configuration of the subscription target.
    subscription_target_config: []const SubscriptionTargetForm,

    /// The type of the subscription target.
    type: []const u8,

    /// The timestamp of when the subscription target was updated.
    updated_at: ?i64,

    /// The Amazon DataZone user who updated the subscription target.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .applicable_asset_types = "applicableAssetTypes",
        .authorized_principals = "authorizedPrincipals",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .environment_id = "environmentId",
        .id = "id",
        .manage_access_role = "manageAccessRole",
        .name = "name",
        .project_id = "projectId",
        .provider = "provider",
        .subscription_grant_creation_mode = "subscriptionGrantCreationMode",
        .subscription_target_config = "subscriptionTargetConfig",
        .type = "type",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
