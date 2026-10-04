const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

pub const SubmitRegistryRecordForApprovalInput = struct {
    /// The identifier of the registry record to submit for approval. You can
    /// specify either the Amazon Resource Name (ARN) or the ID of the record.
    record_id: []const u8,

    /// The identifier of the registry containing the record. You can specify either
    /// the Amazon Resource Name (ARN) or the ID of the registry.
    registry_id: []const u8,

    pub const json_field_names = .{
        .record_id = "recordId",
        .registry_id = "registryId",
    };
};

pub const SubmitRegistryRecordForApprovalOutput = struct {
    /// The Amazon Resource Name (ARN) of the registry record.
    record_arn: []const u8,

    /// The unique identifier of the registry record.
    record_id: []const u8,

    /// The Amazon Resource Name (ARN) of the registry that contains the record.
    registry_arn: []const u8,

    /// The resulting status of the registry record after submission.
    status: RegistryRecordStatus,

    /// The timestamp when the record was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .record_arn = "recordArn",
        .record_id = "recordId",
        .registry_arn = "registryArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubmitRegistryRecordForApprovalInput, options: CallOptions) !SubmitRegistryRecordForApprovalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SubmitRegistryRecordForApprovalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/records/");
    try path_buf.appendSlice(allocator, input.record_id);
    try path_buf.appendSlice(allocator, "/submit-for-approval");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SubmitRegistryRecordForApprovalOutput {
    var result: SubmitRegistryRecordForApprovalOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SubmitRegistryRecordForApprovalOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
