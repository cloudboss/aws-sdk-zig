const OriginGroupFailoverCriteria = @import("origin_group_failover_criteria.zig").OriginGroupFailoverCriteria;
const OriginGroupMembers = @import("origin_group_members.zig").OriginGroupMembers;
const OriginGroupSelectionCriteria = @import("origin_group_selection_criteria.zig").OriginGroupSelectionCriteria;

/// An origin group includes two origins (a primary origin and a secondary
/// origin to failover to) and a failover criteria that you specify. You create
/// an origin group to support origin failover in CloudFront. When you create or
/// update a distribution, you can specify the origin group instead of a single
/// origin, and CloudFront will failover from the primary origin to the
/// secondary origin under the failover conditions that you've chosen.
///
/// Optionally, you can choose selection criteria for your origin group to
/// specify how your origins are selected when your distribution routes viewer
/// requests.
pub const OriginGroup = struct {
    /// A complex type that contains information about the failover criteria for an
    /// origin group.
    failover_criteria: OriginGroupFailoverCriteria,

    /// The origin group's ID.
    id: []const u8,

    /// A complex type that contains information about the origins in an origin
    /// group.
    members: OriginGroupMembers,

    /// The selection criteria for the origin group. For more information, see
    /// [Create an origin
    /// group](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/high_availability_origin_failover.html#concept_origin_groups.creating) in the *Amazon CloudFront Developer Guide*.
    selection_criteria: ?OriginGroupSelectionCriteria,
};
