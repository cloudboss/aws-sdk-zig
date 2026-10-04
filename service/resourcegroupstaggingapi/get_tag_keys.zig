const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetTagKeysInput = struct {
    /// Specifies a `PaginationToken` response value from a
    /// previous request to indicate that you want the next page of results. Leave
    /// this parameter empty
    /// in your initial request.
    pagination_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .pagination_token = "PaginationToken",
    };
};

pub const GetTagKeysOutput = struct {
    /// A string that indicates that there is more data available than this
    /// response contains. To receive the next part of the response, specify this
    /// response value
    /// as the `PaginationToken` value in the request for the next page.
    pagination_token: ?[]const u8 = null,

    /// A list of all tag keys in the Amazon Web Services account.
    tag_keys: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .pagination_token = "PaginationToken",
        .tag_keys = "TagKeys",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTagKeysInput, options: CallOptions) !GetTagKeysOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tagging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTagKeysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tagging", "Resource Groups Tagging API", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ResourceGroupsTaggingAPI_20170126.GetTagKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTagKeysOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTagKeysOutput, body, allocator);
}
