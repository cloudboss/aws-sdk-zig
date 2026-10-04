const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KnowledgeBaseData = @import("knowledge_base_data.zig").KnowledgeBaseData;

pub const GetKnowledgeBaseInput = struct {
    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it. Can be either the ID
    /// or the ARN. URLs cannot contain the ARN.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
    };
};

pub const GetKnowledgeBaseOutput = struct {
    /// The knowledge base.
    knowledge_base: ?KnowledgeBaseData = null,

    pub const json_field_names = .{
        .knowledge_base = "knowledgeBase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKnowledgeBaseInput, options: CallOptions) !GetKnowledgeBaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKnowledgeBaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "Wisdom", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKnowledgeBaseOutput {
    const result: GetKnowledgeBaseOutput = try aws.json.parseJsonObject(
        GetKnowledgeBaseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
