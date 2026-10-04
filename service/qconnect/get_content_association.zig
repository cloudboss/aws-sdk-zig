const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContentAssociationData = @import("content_association_data.zig").ContentAssociationData;

pub const GetContentAssociationInput = struct {
    /// The identifier of the content association. Can be either the ID or the ARN.
    /// URLs cannot contain the ARN.
    content_association_id: []const u8,

    /// The identifier of the content.
    content_id: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .content_association_id = "contentAssociationId",
        .content_id = "contentId",
        .knowledge_base_id = "knowledgeBaseId",
    };
};

pub const GetContentAssociationOutput = struct {
    /// The association between Amazon Q in Connect content and another resource.
    content_association: ?ContentAssociationData = null,

    pub const json_field_names = .{
        .content_association = "contentAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetContentAssociationInput, options: CallOptions) !GetContentAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetContentAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/contents/");
    try path_buf.appendSlice(allocator, input.content_id);
    try path_buf.appendSlice(allocator, "/associations/");
    try path_buf.appendSlice(allocator, input.content_association_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetContentAssociationOutput {
    var result: GetContentAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetContentAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
