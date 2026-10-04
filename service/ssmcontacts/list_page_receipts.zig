const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Receipt = @import("receipt.zig").Receipt;

pub const ListPageReceiptsInput = struct {
    /// The maximum number of acknowledgements per page of results.
    max_results: ?i32 = null,

    /// The pagination token to continue to the next page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the engagement to a specific contact
    /// channel.
    page_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .page_id = "PageId",
    };
};

pub const ListPageReceiptsOutput = struct {
    /// The pagination token to continue to the next page of results.
    next_token: ?[]const u8 = null,

    /// A list of each acknowledgement.
    receipts: ?[]const Receipt = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .receipts = "Receipts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPageReceiptsInput, options: CallOptions) !ListPageReceiptsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPageReceiptsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.ListPageReceipts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPageReceiptsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPageReceiptsOutput, body, allocator);
}
