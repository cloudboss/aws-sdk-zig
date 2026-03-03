const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;
const SubscribedListing = @import("subscribed_listing.zig").SubscribedListing;
const SubscribedPrincipal = @import("subscribed_principal.zig").SubscribedPrincipal;

/// The details of the subscription.
pub const SubscriptionSummary = struct {
    /// The timestamp of when the subscription was created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription.
    created_by: []const u8,

    /// The identifier of the Amazon DataZone domain in which a subscription exists.
    domain_id: []const u8,

    /// The identifier of the subscription.
    id: []const u8,

    /// The retain permissions included in the subscription.
    retain_permissions: ?bool = null,

    /// The status of the subscription.
    status: SubscriptionStatus,

    /// The listing included in the subscription.
    subscribed_listing: SubscribedListing,

    /// The principal included in the subscription.
    subscribed_principal: SubscribedPrincipal,

    /// The identifier of the subscription request for the subscription.
    subscription_request_id: ?[]const u8 = null,

    /// The timestamp of when the subscription was updated.
    updated_at: i64,

    /// The Amazon DataZone user who updated the subscription.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .retain_permissions = "retainPermissions",
        .status = "status",
        .subscribed_listing = "subscribedListing",
        .subscribed_principal = "subscribedPrincipal",
        .subscription_request_id = "subscriptionRequestId",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
