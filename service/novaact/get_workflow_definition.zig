const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowExportConfig = @import("workflow_export_config.zig").WorkflowExportConfig;
const WorkflowDefinitionStatus = @import("workflow_definition_status.zig").WorkflowDefinitionStatus;

pub const GetWorkflowDefinitionInput = struct {
    /// The name of the workflow definition to retrieve.
    workflow_definition_name: []const u8,

    pub const json_field_names = .{
        .workflow_definition_name = "workflowDefinitionName",
    };
};

pub const GetWorkflowDefinitionOutput = struct {
    /// The Amazon Resource Name (ARN) of the workflow definition.
    arn: []const u8,

    /// The timestamp when the workflow definition was created.
    created_at: i64,

    /// The description of the workflow definition.
    description: ?[]const u8 = null,

    /// The export configuration for the workflow definition.
    export_config: ?WorkflowExportConfig = null,

    /// The name of the workflow definition.
    name: []const u8,

    /// The current status of the workflow definition.
    status: WorkflowDefinitionStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .export_config = "exportConfig",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowDefinitionInput, options: CallOptions) !GetWorkflowDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("nova-act", "Nova Act", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow-definitions/");
    try path_buf.appendSlice(allocator, input.workflow_definition_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowDefinitionOutput {
    const result: GetWorkflowDefinitionOutput = try aws.json.parseJsonObject(
        GetWorkflowDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
