const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceInput = struct {
    /// Requests the tags associated with a particular Amazon Resource Name (ARN).
    /// An ARN is an identifier for a specific Amazon Web Services resource, such as
    /// a server, user, or role.
    arn: []const u8,

    /// Specifies the number of tags to return as a response to the
    /// `ListTagsForResource` request.
    max_results: ?i32 = null,

    /// When you request additional results from the `ListTagsForResource`
    /// operation, a `NextToken` parameter is returned in the input. You can then
    /// pass in a subsequent command to the `NextToken` parameter to continue
    /// listing additional tags.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListTagsForResourceOutput = struct {
    /// The ARN you specified to list the tags of.
    arn: ?[]const u8 = null,

    /// When you can get additional results from the `ListTagsForResource` call, a
    /// `NextToken` parameter is returned in the output. You can then pass in a
    /// subsequent command to the `NextToken` parameter to continue listing
    /// additional tags.
    next_token: ?[]const u8 = null,

    /// Key-value pairs that are assigned to a resource, usually for the purpose of
    /// grouping and searching for items. Tags are metadata that you define.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .next_token = "NextToken",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsForResourceInput, options: CallOptions) !ListTagsForResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsForResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ListTagsForResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsForResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTagsForResourceOutput, body, allocator);
}
