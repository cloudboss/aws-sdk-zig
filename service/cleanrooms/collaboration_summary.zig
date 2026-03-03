const AnalyticsEngine = @import("analytics_engine.zig").AnalyticsEngine;
const MemberStatus = @import("member_status.zig").MemberStatus;

/// The metadata of the collaboration.
pub const CollaborationSummary = struct {
    /// The analytics engine.
    ///
    /// After July 16, 2025, the `CLEAN_ROOMS_SQL` parameter will no longer be
    /// available.
    analytics_engine: ?AnalyticsEngine = null,

    /// The ARN of the collaboration.
    arn: []const u8,

    /// The time when the collaboration was created.
    create_time: i64,

    /// The identifier used to reference members of the collaboration. Currently
    /// only supports Amazon Web Services account ID.
    creator_account_id: []const u8,

    /// The display name of the collaboration creator.
    creator_display_name: []const u8,

    /// The identifier for the collaboration.
    id: []const u8,

    /// The ARN of a member in a collaboration.
    membership_arn: ?[]const u8 = null,

    /// The identifier of a member in a collaboration.
    membership_id: ?[]const u8 = null,

    /// The status of a member in a collaboration.
    member_status: MemberStatus,

    /// A human-readable identifier provided by the collaboration owner. Display
    /// names are not unique.
    name: []const u8,

    /// The time the collaboration metadata was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analytics_engine = "analyticsEngine",
        .arn = "arn",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .creator_display_name = "creatorDisplayName",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .member_status = "memberStatus",
        .name = "name",
        .update_time = "updateTime",
    };
};
