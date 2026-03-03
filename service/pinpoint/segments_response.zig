const SegmentResponse = @import("segment_response.zig").SegmentResponse;

/// Provides information about all the segments that are associated with an
/// application.
pub const SegmentsResponse = struct {
    /// An array of responses, one for each segment that's associated with the
    /// application (Segments resource) or each version of a segment that's
    /// associated with the application (Segment Versions resource).
    item: []const SegmentResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
