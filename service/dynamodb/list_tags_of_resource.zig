const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const ListTagsOfResourceInput = struct {
    /// An optional string that, if supplied, must be copied from the output of a
    /// previous
    /// call to ListTagOfResource. When provided in this manner, this API fetches
    /// the next page
    /// of results.
    next_token: ?[]const u8 = null,

    /// The Amazon DynamoDB resource with tags to be listed. This value is an Amazon
    /// Resource
    /// Name (ARN).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
    };
};

pub const ListTagsOfResourceOutput = struct {
    /// If this value is returned, there are additional results to be displayed. To
    /// retrieve
    /// them, call ListTagsOfResource again, with NextToken set to this value.
    next_token: ?[]const u8 = null,

    /// The tags currently associated with the Amazon DynamoDB resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsOfResourceInput, options: CallOptions) !ListTagsOfResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsOfResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ListTagsOfResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsOfResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTagsOfResourceOutput, body, allocator);
}
