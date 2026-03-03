const TemplateResponse = @import("template_response.zig").TemplateResponse;

/// Provides information about all the message templates that are associated
/// with your Amazon Pinpoint account.
pub const TemplatesResponse = struct {
    /// An array of responses, one for each message template that's associated with
    /// your Amazon Pinpoint account and meets any filter criteria that you
    /// specified in the request.
    item: []const TemplateResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
