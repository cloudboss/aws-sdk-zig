const MetadataFormSummary = @import("metadata_form_summary.zig").MetadataFormSummary;
const SubscriptionRequestStatus = @import("subscription_request_status.zig").SubscriptionRequestStatus;
const SubscribedListing = @import("subscribed_listing.zig").SubscribedListing;
const SubscribedPrincipal = @import("subscribed_principal.zig").SubscribedPrincipal;

/// The details of the subscription request.
pub const SubscriptionRequestSummary = struct {
    /// The timestamp of when a subscription request was created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription request.
    created_by: []const u8,

    /// The decision comment of the subscription request.
    decision_comment: ?[]const u8,

    /// The identifier of the Amazon DataZone domain in which a subscription request
    /// exists.
    domain_id: []const u8,

    /// The ID of the existing subscription.
    existing_subscription_id: ?[]const u8,

    /// The identifier of the subscription request.
    id: []const u8,

    /// The summary of the metadata forms.
    metadata_forms_summary: ?[]const MetadataFormSummary,

    /// The reason for the subscription request.
    request_reason: []const u8,

    /// The identifier of the subscription request reviewer.
    reviewer_id: ?[]const u8,

    /// The status of the subscription request.
    status: SubscriptionRequestStatus,

    /// The listings included in the subscription request.
    subscribed_listings: []const SubscribedListing,

    /// The principals included in the subscription request.
    subscribed_principals: []const SubscribedPrincipal,

    /// The timestamp of when the subscription request was updated.
    updated_at: i64,

    /// The identifier of the Amazon DataZone user who updated the subscription
    /// request.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .decision_comment = "decisionComment",
        .domain_id = "domainId",
        .existing_subscription_id = "existingSubscriptionId",
        .id = "id",
        .metadata_forms_summary = "metadataFormsSummary",
        .request_reason = "requestReason",
        .reviewer_id = "reviewerId",
        .status = "status",
        .subscribed_listings = "subscribedListings",
        .subscribed_principals = "subscribedPrincipals",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
