const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStepItem = @import("workflow_step_item.zig").WorkflowStepItem;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

pub const GetWorkflowStepsInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// Unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .workflow_id = "WorkflowId",
    };
};

pub const GetWorkflowStepsOutput = struct {
    /// List containing workflow step details.
    items: ?[]const WorkflowStepItem = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// Unique identifier for the workflow.
    workflow_id: ?[]const u8 = null,

    /// The type of workflow. The only supported value is APPFLOW_INTEGRATION.
    workflow_type: ?WorkflowType = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
        .workflow_id = "WorkflowId",
        .workflow_type = "WorkflowType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowStepsInput, options: CallOptions) !GetWorkflowStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowStepsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/workflows/");
    try path_buf.appendSlice(allocator, input.workflow_id);
    try path_buf.appendSlice(allocator, "/steps");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowStepsOutput {
    var result: GetWorkflowStepsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkflowStepsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
