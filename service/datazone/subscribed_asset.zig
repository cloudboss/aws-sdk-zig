const AssetScope = @import("asset_scope.zig").AssetScope;
const FailureCause = @import("failure_cause.zig").FailureCause;
const Permissions = @import("permissions.zig").Permissions;
const SubscriptionGrantStatus = @import("subscription_grant_status.zig").SubscriptionGrantStatus;

/// The details of the asset for which the subscription grant is created.
pub const SubscribedAsset = struct {
    /// The identifier of the asset for which the subscription grant is created.
    asset_id: []const u8,

    /// The revision of the asset for which the subscription grant is created.
    asset_revision: []const u8,

    /// The asset scope of the subscribed asset.
    asset_scope: ?AssetScope = null,

    /// The failure cause included in the details of the asset for which the
    /// subscription grant is created.
    failure_cause: ?FailureCause = null,

    /// The failure timestamp included in the details of the asset for which the
    /// subscription grant is created.
    failure_timestamp: ?i64 = null,

    /// The timestamp of when the subscription grant to the asset is created.
    granted_timestamp: ?i64 = null,

    /// The asset permissions.
    permissions: ?Permissions = null,

    /// The status of the asset for which the subscription grant is created.
    status: SubscriptionGrantStatus,

    /// The target name of the asset for which the subscription grant is created.
    target_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .asset_revision = "assetRevision",
        .asset_scope = "assetScope",
        .failure_cause = "failureCause",
        .failure_timestamp = "failureTimestamp",
        .granted_timestamp = "grantedTimestamp",
        .permissions = "permissions",
        .status = "status",
        .target_name = "targetName",
    };
};
