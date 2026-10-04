const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStepMetadata = @import("workflow_step_metadata.zig").WorkflowStepMetadata;

pub const ListWorkflowStepExecutionsInput = struct {
    /// Specify the maximum number of items to return in a request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. This is the nextToken
    /// from a previously truncated response.
    next_token: ?[]const u8 = null,

    /// The unique identifier that Image Builder assigned to keep track of runtime
    /// details
    /// when it ran the workflow.
    workflow_execution_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .workflow_execution_id = "workflowExecutionId",
    };
};

pub const ListWorkflowStepExecutionsOutput = struct {
    /// The image build version resource Amazon Resource Name (ARN) that's
    /// associated with the specified runtime
    /// instance of the workflow.
    image_build_version_arn: ?[]const u8 = null,

    /// The output message from the list action, if applicable.
    message: ?[]const u8 = null,

    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token
    /// with the next request to retrieve additional objects.
    next_token: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    /// Contains an array of runtime details that represents each step in this
    /// runtime
    /// instance of the workflow.
    steps: ?[]const WorkflowStepMetadata = null,

    /// The build version Amazon Resource Name (ARN) for the Image Builder workflow
    /// resource that defines the steps for
    /// this runtime instance of the workflow.
    workflow_build_version_arn: ?[]const u8 = null,

    /// The unique identifier that Image Builder assigned to keep track of runtime
    /// details
    /// when it ran the workflow.
    workflow_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_build_version_arn = "imageBuildVersionArn",
        .message = "message",
        .next_token = "nextToken",
        .request_id = "requestId",
        .steps = "steps",
        .workflow_build_version_arn = "workflowBuildVersionArn",
        .workflow_execution_id = "workflowExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowStepExecutionsInput, options: CallOptions) !ListWorkflowStepExecutionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowStepExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListWorkflowStepExecutions";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workflowExecutionId\":");
    try aws.json.writeValue(@TypeOf(input.workflow_execution_id), input.workflow_execution_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowStepExecutionsOutput {
    var result: ListWorkflowStepExecutionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWorkflowStepExecutionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
