const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointConfig = @import("endpoint_config.zig").EndpointConfig;
const RevisionConfig = @import("revision_config.zig").RevisionConfig;
const FunctionEndpointSummary = @import("function_endpoint_summary.zig").FunctionEndpointSummary;
const FunctionRevisionSummary = @import("function_revision_summary.zig").FunctionRevisionSummary;
const FunctionState = @import("function_state.zig").FunctionState;

pub const CreateWebFunctionInput = struct {
    /// The configuration for the initial endpoint of the web function.
    endpoint_config: ?EndpointConfig = null,

    /// The name of the web function. The name can contain letters, numbers, hyphens
    /// (-), and underscores (_), and can't begin or end with a hyphen or an
    /// underscore. The length constraint applies only to the full ARN. If you
    /// specify only the function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// The configuration for the initial revision of the web function, including
    /// code and service settings.
    revision_config: ?RevisionConfig = null,

    /// A map of tag keys and values to apply to the web function.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .endpoint_config = "endpointConfig",
        .function_name = "functionName",
        .revision_config = "revisionConfig",
        .tags = "tags",
    };
};

pub const CreateWebFunctionOutput = struct {
    /// The date and time the web function was created.
    created_at: i64,

    /// A summary of the initial endpoint created with the web function.
    endpoint: ?FunctionEndpointSummary = null,

    /// The Amazon Resource Name (ARN) of the web function.
    function_arn: []const u8,

    /// The name of the web function.
    function_name: []const u8,

    /// A summary of the initial revision created with the web function.
    revision: ?FunctionRevisionSummary = null,

    /// The current state of the web function.
    state: FunctionState,

    /// The reason for the current state of the web function.
    state_reason: []const u8,

    /// A map of tag keys and values associated with the web function.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time the web function was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .endpoint = "endpoint",
        .function_arn = "functionArn",
        .function_name = "functionName",
        .revision = "revision",
        .state = "state",
        .state_reason = "stateReason",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebFunctionInput, options: CallOptions) !CreateWebFunctionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2025-03-07/web-functions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.endpoint_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endpointConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"functionName\":");
    try aws.json.writeValue(@TypeOf(input.function_name), input.function_name, allocator, &body_buf);
    has_prev = true;
    if (input.revision_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"revisionConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebFunctionOutput {
    const result: CreateWebFunctionOutput = try aws.json.parseJsonObject(
        CreateWebFunctionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
