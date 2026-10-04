const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionPreview = @import("execution_preview.zig").ExecutionPreview;
const ExecutionPreviewStatus = @import("execution_preview_status.zig").ExecutionPreviewStatus;

pub const GetExecutionPreviewInput = struct {
    /// The ID of the existing execution preview.
    execution_preview_id: []const u8,

    pub const json_field_names = .{
        .execution_preview_id = "ExecutionPreviewId",
    };
};

pub const GetExecutionPreviewOutput = struct {
    /// A UTC timestamp indicating when the execution preview operation ended.
    ended_at: ?i64 = null,

    execution_preview: ?ExecutionPreview = null,

    /// The generated ID for the existing execution preview.
    execution_preview_id: ?[]const u8 = null,

    /// The current status of the execution preview operation.
    status: ?ExecutionPreviewStatus = null,

    /// Supplemental information about the current status of the execution preview.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .ended_at = "EndedAt",
        .execution_preview = "ExecutionPreview",
        .execution_preview_id = "ExecutionPreviewId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExecutionPreviewInput, options: CallOptions) !GetExecutionPreviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExecutionPreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetExecutionPreview");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExecutionPreviewOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetExecutionPreviewOutput, body, allocator);
}
