const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecycleExecutionState = @import("lifecycle_execution_state.zig").LifecycleExecutionState;
const LifecycleExecutionResource = @import("lifecycle_execution_resource.zig").LifecycleExecutionResource;

pub const ListLifecycleExecutionResourcesInput = struct {
    /// The unique identifier for a runtime instance of the lifecycle policy.
    lifecycle_execution_id: []const u8,

    /// The maximum number of items to return in a single request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. Use the `nextToken` value
    /// from a previously truncated response.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an image build version to get the output
    /// resources for,
    /// such as AMIs or container images in Amazon ECR. You can get this value from
    /// the
    /// `resourceId` in the top-level response. If you leave this
    /// property empty, the response lists the Image Builder resources that the
    /// lifecycle
    /// execution identified for lifecycle actions. If the image build version that
    /// you specify in `parentResourceId` wasn't part of this
    /// lifecycle execution, the response contains an empty list.
    parent_resource_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle_execution_id = "lifecycleExecutionId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .parent_resource_id = "parentResourceId",
    };
};

pub const ListLifecycleExecutionResourcesOutput = struct {
    /// The unique identifier for the runtime instance of the lifecycle policy.
    lifecycle_execution_id: ?[]const u8 = null,

    /// The current state of the lifecycle runtime instance.
    lifecycle_execution_state: ?LifecycleExecutionState = null,

    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token
    /// with the next request to retrieve additional objects.
    next_token: ?[]const u8 = null,

    /// A list of resources that were identified for lifecycle actions.
    resources: ?[]const LifecycleExecutionResource = null,

    pub const json_field_names = .{
        .lifecycle_execution_id = "lifecycleExecutionId",
        .lifecycle_execution_state = "lifecycleExecutionState",
        .next_token = "nextToken",
        .resources = "resources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLifecycleExecutionResourcesInput, options: CallOptions) !ListLifecycleExecutionResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLifecycleExecutionResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListLifecycleExecutionResources";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lifecycleExecutionId\":");
    try aws.json.writeValue(@TypeOf(input.lifecycle_execution_id), input.lifecycle_execution_id, allocator, &body_buf);
    has_prev = true;
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
    if (input.parent_resource_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentResourceId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLifecycleExecutionResourcesOutput {
    const result: ListLifecycleExecutionResourcesOutput = try aws.json.parseJsonObject(
        ListLifecycleExecutionResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
