const TemplateVersionResponse = @import("template_version_response.zig").TemplateVersionResponse;

/// Provides information about all the versions of a specific message template.
pub const TemplateVersionsResponse = struct {
    /// An array of responses, one for each version of the message template.
    item: []const TemplateVersionResponse,

    /// The message that's returned from the API for the request to retrieve
    /// information about all the versions of the message template.
    message: ?[]const u8 = null,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    /// The unique identifier for the request to retrieve information about all the
    /// versions of the message template.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .item = "Item",
        .message = "Message",
        .next_token = "NextToken",
        .request_id = "RequestID",
    };
};
