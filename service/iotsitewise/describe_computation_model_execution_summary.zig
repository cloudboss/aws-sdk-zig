const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResolveToResourceType = @import("resolve_to_resource_type.zig").ResolveToResourceType;
const ResolveTo = @import("resolve_to.zig").ResolveTo;

pub const DescribeComputationModelExecutionSummaryInput = struct {
    /// The ID of the computation model.
    computation_model_id: []const u8,

    /// The ID of the resolved resource.
    resolve_to_resource_id: ?[]const u8 = null,

    /// The type of the resolved resource.
    resolve_to_resource_type: ?ResolveToResourceType = null,

    pub const json_field_names = .{
        .computation_model_id = "computationModelId",
        .resolve_to_resource_id = "resolveToResourceId",
        .resolve_to_resource_type = "resolveToResourceType",
    };
};

pub const DescribeComputationModelExecutionSummaryOutput = struct {
    /// Contains the execution summary of the computation model.
    computation_model_execution_summary: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the computation model.
    computation_model_id: []const u8,

    /// The detailed resource this execution summary resolves to.
    resolve_to: ?ResolveTo = null,

    pub const json_field_names = .{
        .computation_model_execution_summary = "computationModelExecutionSummary",
        .computation_model_id = "computationModelId",
        .resolve_to = "resolveTo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeComputationModelExecutionSummaryInput, options: CallOptions) !DescribeComputationModelExecutionSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeComputationModelExecutionSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/computation-models/");
    try path_buf.appendSlice(allocator, input.computation_model_id);
    try path_buf.appendSlice(allocator, "/execution-summary");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.resolve_to_resource_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resolveToResourceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resolve_to_resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resolveToResourceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeComputationModelExecutionSummaryOutput {
    const result: DescribeComputationModelExecutionSummaryOutput = try aws.json.parseJsonObject(
        DescribeComputationModelExecutionSummaryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
