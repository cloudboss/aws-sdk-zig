const SpaceDetails = @import("space_details.zig").SpaceDetails;

pub const ListSpacesResponse = struct {
    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8,

    /// The list of spaces.
    spaces: ?[]const SpaceDetails,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .spaces = "Spaces",
    };
};
