const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Topic = @import("topic.zig").Topic;

pub const GetContactListInput = struct {
    /// The name of the contact list.
    contact_list_name: []const u8,

    pub const json_field_names = .{
        .contact_list_name = "ContactListName",
    };
};

pub const GetContactListOutput = struct {
    /// The name of the contact list.
    contact_list_name: ?[]const u8 = null,

    /// A timestamp noting when the contact list was created.
    created_timestamp: ?i64 = null,

    /// A description of what the contact list is about.
    description: ?[]const u8 = null,

    /// A timestamp noting the last time the contact list was updated.
    last_updated_timestamp: ?i64 = null,

    /// The tags associated with a contact list.
    tags: ?[]const Tag = null,

    /// An interest group, theme, or label within a list. A contact list can have
    /// multiple
    /// topics.
    topics: ?[]const Topic = null,

    pub const json_field_names = .{
        .contact_list_name = "ContactListName",
        .created_timestamp = "CreatedTimestamp",
        .description = "Description",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .tags = "Tags",
        .topics = "Topics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetContactListInput, options: CallOptions) !GetContactListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetContactListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/contact-lists/");
    try path_buf.appendSlice(allocator, input.contact_list_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetContactListOutput {
    var result: GetContactListOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetContactListOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
