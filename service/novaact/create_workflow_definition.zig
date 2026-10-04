const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowExportConfig = @import("workflow_export_config.zig").WorkflowExportConfig;
const WorkflowDefinitionStatus = @import("workflow_definition_status.zig").WorkflowDefinitionStatus;

pub const CreateWorkflowDefinitionInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// An optional description of the workflow definition's purpose and
    /// functionality.
    description: ?[]const u8 = null,

    /// Configuration for exporting workflow execution data to Amazon Simple Storage
    /// Service.
    export_config: ?WorkflowExportConfig = null,

    /// The name of the workflow definition. Must be unique within your account and
    /// region.
    name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .export_config = "exportConfig",
        .name = "name",
    };
};

pub const CreateWorkflowDefinitionOutput = struct {
    /// The current status of the workflow definition after creation.
    status: WorkflowDefinitionStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkflowDefinitionInput, options: CallOptions) !CreateWorkflowDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "nova-act", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkflowDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("nova-act", "Nova Act", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/workflow-definitions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.export_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exportConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkflowDefinitionOutput {
    var result: CreateWorkflowDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateWorkflowDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
