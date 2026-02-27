const JourneyResponse = @import("journey_response.zig").JourneyResponse;

/// Provides information about the status, configuration, and other settings for
/// all the journeys that are associated with an application.
pub const JourneysResponse = struct {
    /// An array of responses, one for each journey that's associated with the
    /// application.
    item: []const JourneyResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
