const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QuickResponseData = @import("quick_response_data.zig").QuickResponseData;

pub const GetQuickResponseInput = struct {
    /// The identifier of the knowledge base. This should be a QUICK_RESPONSES type
    /// knowledge base.
    knowledge_base_id: []const u8,

    /// The identifier of the quick response.
    quick_response_id: []const u8,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
        .quick_response_id = "quickResponseId",
    };
};

pub const GetQuickResponseOutput = struct {
    /// The quick response.
    quick_response: ?QuickResponseData = null,

    pub const json_field_names = .{
        .quick_response = "quickResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQuickResponseInput, options: CallOptions) !GetQuickResponseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQuickResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "Wisdom", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/quickResponses/");
    try path_buf.appendSlice(allocator, input.quick_response_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQuickResponseOutput {
    const result: GetQuickResponseOutput = try aws.json.parseJsonObject(
        GetQuickResponseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
