const ContentModerationAggregateBy = @import("content_moderation_aggregate_by.zig").ContentModerationAggregateBy;
const ContentModerationSortBy = @import("content_moderation_sort_by.zig").ContentModerationSortBy;

/// Contains metadata about a content moderation request, including the SortBy
/// and AggregateBy
/// options.
pub const GetContentModerationRequestMetadata = struct {
    /// The aggregation method chosen for a GetContentModeration request.
    aggregate_by: ?ContentModerationAggregateBy,

    /// The sorting method chosen for a GetContentModeration request.
    sort_by: ?ContentModerationSortBy,

    pub const json_field_names = .{
        .aggregate_by = "AggregateBy",
        .sort_by = "SortBy",
    };
};
