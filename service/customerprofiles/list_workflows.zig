const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Status = @import("status.zig").Status;
const WorkflowType = @import("workflow_type.zig").WorkflowType;
const ListWorkflowsItem = @import("list_workflows_item.zig").ListWorkflowsItem;

pub const ListWorkflowsInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// Retrieve workflows ended after timestamp.
    query_end_date: ?i64 = null,

    /// Retrieve workflows started after timestamp.
    query_start_date: ?i64 = null,

    /// Status of workflow execution.
    status: ?Status = null,

    /// The type of workflow. The only supported value is APPFLOW_INTEGRATION.
    workflow_type: ?WorkflowType = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .query_end_date = "QueryEndDate",
        .query_start_date = "QueryStartDate",
        .status = "Status",
        .workflow_type = "WorkflowType",
    };
};

pub const ListWorkflowsOutput = struct {
    /// List containing workflow details.
    items: ?[]const ListWorkflowsItem = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowsInput, options: CallOptions) !ListWorkflowsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/workflows");
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.query_end_date) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryEndDate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_start_date) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryStartDate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflow_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WorkflowType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowsOutput {
    var result: ListWorkflowsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWorkflowsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
