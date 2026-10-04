const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeNode = @import("compute_node.zig").ComputeNode;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const DescribePipelineInput = struct {
    /// The name of the pipeline.
    pipeline_name: []const u8,

    /// The version number of the pipeline to retrieve. If not specified, returns
    /// the latest version.
    pipeline_version: ?[]const u8 = null,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .pipeline_name = "pipelineName",
        .pipeline_version = "pipelineVersion",
        .workspace_name = "workspaceName",
    };
};

pub const DescribePipelineOutput = struct {
    /// The list of compute nodes that form the pipeline DAG.
    computations: ?[]const ComputeNode = null,

    /// The time the pipeline was created, in Unix epoch time.
    created_at: i64,

    /// The description of the pipeline.
    description: ?[]const u8 = null,

    /// The environment variables shared across all compute nodes in the pipeline.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the pipeline.
    pipeline_arn: []const u8,

    /// A unique name of the pipeline within the workspace.
    pipeline_name: []const u8,

    /// The current lifecycle status of the pipeline.
    status: ?ResourceStatus = null,

    /// The time the pipeline was last updated, in Unix epoch time.
    updated_at: i64,

    /// The version of the pipeline.
    version: []const u8,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .computations = "computations",
        .created_at = "createdAt",
        .description = "description",
        .environment_variables = "environmentVariables",
        .pipeline_arn = "pipelineArn",
        .pipeline_name = "pipelineName",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePipelineInput, options: CallOptions) !DescribePipelineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/pipelines/");
    try path_buf.appendSlice(allocator, input.pipeline_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.pipeline_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePipelineOutput {
    const result: DescribePipelineOutput = try aws.json.parseJsonObject(
        DescribePipelineOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
