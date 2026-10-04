const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResolutionContact = @import("resolution_contact.zig").ResolutionContact;

pub const ListPageResolutionsInput = struct {
    /// A token to start the list. Use this token to get the next set of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the contact engaged for the incident.
    page_id: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_id = "PageId",
    };
};

pub const ListPageResolutionsOutput = struct {
    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// Information about the resolution for an engagement.
    page_resolutions: ?[]const ResolutionContact = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_resolutions = "PageResolutions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPageResolutionsInput, options: CallOptions) !ListPageResolutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPageResolutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-contacts", "SSM Contacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.ListPageResolutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPageResolutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListPageResolutionsOutput, body, allocator);
}
