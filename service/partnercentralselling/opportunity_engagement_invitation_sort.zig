const OpportunityEngagementInvitationSortName = @import("opportunity_engagement_invitation_sort_name.zig").OpportunityEngagementInvitationSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Defines sorting options for retrieving Engagement Invitations. Sorting can
/// be done based on various criteria like the invitation date or status.
pub const OpportunityEngagementInvitationSort = struct {
    /// Specifies the field by which the Engagement Invitations are sorted. Common
    /// values include `InvitationDate` and `Status`.
    sort_by: OpportunityEngagementInvitationSortName,

    /// Defines the order in which the Engagement Invitations are sorted. The values
    /// can be `ASC` (ascending) or `DESC` (descending).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
