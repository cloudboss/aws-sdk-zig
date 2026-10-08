const FeedAssociation = @import("feed_association.zig").FeedAssociation;
const FeedStatus = @import("feed_status.zig").FeedStatus;

/// Contains configuration information about a feed. It is used in the ListFeeds
/// response.
pub const FeedSummary = struct {
    /// The ARN of the feed.
    arn: []const u8,

    /// The resource, if any, associated with the feed.
    association: ?FeedAssociation = null,

    /// The ID of the feed.
    id: []const u8,

    /// The name of the feed
    name: []const u8,

    /// The status of the feed.
    status: FeedStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .association = "association",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
