const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LatestVersionReferences = @import("latest_version_references.zig").LatestVersionReferences;
const Workflow = @import("workflow.zig").Workflow;

pub const GetWorkflowInput = struct {
    /// The Amazon Resource Name (ARN) of the workflow resource that you want to
    /// get. You can specify a
    /// build version ARN, or a version ARN with or without wildcards (`x`)
    /// in its version segments. Image Builder resolves version and wildcard ARNs to
    /// the most
    /// recent matching build version.
    workflow_build_version_arn: []const u8,

    pub const json_field_names = .{
        .workflow_build_version_arn = "workflowBuildVersionArn",
    };
};

pub const GetWorkflowOutput = struct {
    /// A set of wildcard version ARNs that always reference the latest
    /// version of the resource. ARNs are included for the latest version overall,
    /// and for the latest
    /// versions within the same major, minor, and patch levels.
    latest_version_references: ?LatestVersionReferences = null,

    /// The workflow resource specified in the request.
    workflow: ?Workflow = null,

    pub const json_field_names = .{
        .latest_version_references = "latestVersionReferences",
        .workflow = "workflow",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowInput, options: CallOptions) !GetWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetWorkflow";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "workflowBuildVersionArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.workflow_build_version_arn);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowOutput {
    const result: GetWorkflowOutput = try aws.json.parseJsonObject(
        GetWorkflowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
