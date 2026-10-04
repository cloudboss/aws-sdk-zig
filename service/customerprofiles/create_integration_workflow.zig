const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationConfig = @import("integration_config.zig").IntegrationConfig;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

pub const CreateIntegrationWorkflowInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// Configuration data for integration workflow.
    integration_config: IntegrationConfig,

    /// The name of the profile object type.
    object_type_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role. Customer Profiles assumes
    /// this role to create resources on your behalf as part of workflow execution.
    role_arn: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of workflow. The only supported value is APPFLOW_INTEGRATION.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .integration_config = "IntegrationConfig",
        .object_type_name = "ObjectTypeName",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .workflow_type = "WorkflowType",
    };
};

pub const CreateIntegrationWorkflowOutput = struct {
    /// A message indicating create request was received.
    message: []const u8,

    /// Unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .workflow_id = "WorkflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationWorkflowInput, options: CallOptions) !CreateIntegrationWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntegrationWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/workflows/integrations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IntegrationConfig\":");
    try aws.json.writeValue(@TypeOf(input.integration_config), input.integration_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ObjectTypeName\":");
    try aws.json.writeValue(@TypeOf(input.object_type_name), input.object_type_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"WorkflowType\":");
    try aws.json.writeValue(@TypeOf(input.workflow_type), input.workflow_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntegrationWorkflowOutput {
    const result: CreateIntegrationWorkflowOutput = try aws.json.parseJsonObject(
        CreateIntegrationWorkflowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
