const ApplicationResponse = @import("application_response.zig").ApplicationResponse;

/// Provides information about all of your applications.
pub const ApplicationsResponse = struct {
    /// An array of responses, one for each application that was returned.
    item: ?[]const ApplicationResponse = null,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
