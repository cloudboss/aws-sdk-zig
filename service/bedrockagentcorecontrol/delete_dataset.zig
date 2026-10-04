const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const DeleteDatasetInput = struct {
    /// The unique identifier of the dataset to delete.
    dataset_id: []const u8,

    /// Optional version to delete. If absent, deletes the entire dataset. If
    /// provided, deletes only that specific version.
    dataset_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .dataset_version = "datasetVersion",
    };
};

pub const DeleteDatasetOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: []const u8,

    /// The unique identifier of the dataset.
    dataset_id: []const u8,

    /// The version that was deleted.
    dataset_version: []const u8,

    /// The current status of the dataset after the delete request.
    status: DatasetStatus,

    /// The timestamp when the delete was initiated.
    updated_at: i64,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
        .dataset_id = "datasetId",
        .dataset_version = "datasetVersion",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDatasetInput, options: CallOptions) !DeleteDatasetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.dataset_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "datasetVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDatasetOutput {
    const result: DeleteDatasetOutput = try aws.json.parseJsonObject(
        DeleteDatasetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
