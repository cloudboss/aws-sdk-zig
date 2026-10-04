const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowSummary = @import("workflow_summary.zig").WorkflowSummary;

pub const ListWorkflowBuildVersionsInput = struct {
    /// The maximum number of items to return in a single request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. Use the `nextToken` value
    /// from a previously truncated response.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workflow resource for which to get a
    /// list of build versions.
    /// The version segments can contain wildcards (`x`) to match multiple
    /// versions of the workflow. If you don't specify an ARN, the response lists
    /// build
    /// versions for all of the workflows in your account.
    workflow_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .workflow_version_arn = "workflowVersionArn",
    };
};

pub const ListWorkflowBuildVersionsOutput = struct {
    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token
    /// with the next request to retrieve additional objects.
    next_token: ?[]const u8 = null,

    /// A list that contains metadata for the build versions of the workflow
    /// resource specified in the request.
    workflow_summary_list: ?[]const WorkflowSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .workflow_summary_list = "workflowSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowBuildVersionsInput, options: CallOptions) !ListWorkflowBuildVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowBuildVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListWorkflowBuildVersions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflow_version_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflowVersionArn\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowBuildVersionsOutput {
    const result: ListWorkflowBuildVersionsOutput = try aws.json.parseJsonObject(
        ListWorkflowBuildVersionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
