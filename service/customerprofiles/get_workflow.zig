const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowAttributes = @import("workflow_attributes.zig").WorkflowAttributes;
const WorkflowMetrics = @import("workflow_metrics.zig").WorkflowMetrics;
const Status = @import("status.zig").Status;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

pub const GetWorkflowInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// Unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .workflow_id = "WorkflowId",
    };
};

pub const GetWorkflowOutput = struct {
    /// Attributes provided for workflow execution.
    attributes: ?WorkflowAttributes = null,

    /// Workflow error messages during execution (if any).
    error_description: ?[]const u8 = null,

    /// The timestamp that represents when workflow execution last updated.
    last_updated_at: ?i64 = null,

    /// Workflow specific execution metrics.
    metrics: ?WorkflowMetrics = null,

    /// The timestamp that represents when workflow execution started.
    start_date: ?i64 = null,

    /// Status of workflow execution.
    status: ?Status = null,

    /// Unique identifier for the workflow.
    workflow_id: ?[]const u8 = null,

    /// The type of workflow. The only supported value is APPFLOW_INTEGRATION.
    workflow_type: ?WorkflowType = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .error_description = "ErrorDescription",
        .last_updated_at = "LastUpdatedAt",
        .metrics = "Metrics",
        .start_date = "StartDate",
        .status = "Status",
        .workflow_id = "WorkflowId",
        .workflow_type = "WorkflowType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowInput, options: CallOptions) !GetWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/workflows/");
    try path_buf.appendSlice(allocator, input.workflow_id);
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
