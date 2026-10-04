const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetrieverConfiguration = @import("retriever_configuration.zig").RetrieverConfiguration;
const RetrieverStatus = @import("retriever_status.zig").RetrieverStatus;
const RetrieverType = @import("retriever_type.zig").RetrieverType;

pub const GetRetrieverInput = struct {
    /// The identifier of the Amazon Q Business application using the retriever.
    application_id: []const u8,

    /// The identifier of the retriever.
    retriever_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .retriever_id = "retrieverId",
    };
};

pub const GetRetrieverOutput = struct {
    /// The identifier of the Amazon Q Business application using the retriever.
    application_id: ?[]const u8 = null,

    configuration: ?RetrieverConfiguration = null,

    /// The Unix timestamp when the retriever was created.
    created_at: ?i64 = null,

    /// The name of the retriever.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the
    /// retriever.
    retriever_arn: ?[]const u8 = null,

    /// The identifier of the retriever.
    retriever_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role with the permission to access the
    /// retriever and required resources.
    role_arn: ?[]const u8 = null,

    /// The status of the retriever.
    status: ?RetrieverStatus = null,

    /// The type of the retriever.
    @"type": ?RetrieverType = null,

    /// The Unix timestamp when the retriever was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .configuration = "configuration",
        .created_at = "createdAt",
        .display_name = "displayName",
        .retriever_arn = "retrieverArn",
        .retriever_id = "retrieverId",
        .role_arn = "roleArn",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRetrieverInput, options: CallOptions) !GetRetrieverOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRetrieverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/retrievers/");
    try path_buf.appendSlice(allocator, input.retriever_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRetrieverOutput {
    const result: GetRetrieverOutput = try aws.json.parseJsonObject(
        GetRetrieverOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
