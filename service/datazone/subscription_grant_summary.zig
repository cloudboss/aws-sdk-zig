const SubscribedAsset = @import("subscribed_asset.zig").SubscribedAsset;
const GrantedEntity = @import("granted_entity.zig").GrantedEntity;
const SubscriptionGrantOverallStatus = @import("subscription_grant_overall_status.zig").SubscriptionGrantOverallStatus;

/// The details of the subscription grant.
pub const SubscriptionGrantSummary = struct {
    /// The assets included in the subscription grant.
    assets: ?[]const SubscribedAsset = null,

    /// The timestamp of when a subscription grant was created.
    created_at: i64,

    /// The datazone user who created the subscription grant.
    created_by: []const u8,

    /// The identifier of the Amazon DataZone domain in which a subscription grant
    /// exists.
    domain_id: []const u8,

    /// The environment ID of the subscription grant.
    environment_id: ?[]const u8 = null,

    /// The entity to which the subscription is granted.
    granted_entity: GrantedEntity,

    /// The identifier of the subscription grant.
    id: []const u8,

    /// The status of the subscription grant.
    status: SubscriptionGrantOverallStatus,

    /// The ID of the subscription.
    subscription_id: ?[]const u8 = null,

    /// The identifier of the target of the subscription grant.
    subscription_target_id: []const u8,

    /// The timestamp of when the subscription grant was updated.
    updated_at: i64,

    /// The Amazon DataZone user who updated the subscription grant.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .assets = "assets",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .environment_id = "environmentId",
        .granted_entity = "grantedEntity",
        .id = "id",
        .status = "status",
        .subscription_id = "subscriptionId",
        .subscription_target_id = "subscriptionTargetId",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
