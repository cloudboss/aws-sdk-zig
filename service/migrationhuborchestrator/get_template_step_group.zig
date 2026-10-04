const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StepGroupStatus = @import("step_group_status.zig").StepGroupStatus;
const Tool = @import("tool.zig").Tool;

pub const GetTemplateStepGroupInput = struct {
    /// The ID of the step group.
    id: []const u8,

    /// The ID of the template.
    template_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .template_id = "templateId",
    };
};

pub const GetTemplateStepGroupOutput = struct {
    /// The time at which the step group was created.
    creation_time: ?i64 = null,

    /// The description of the step group.
    description: ?[]const u8 = null,

    /// The ID of the step group.
    id: ?[]const u8 = null,

    /// The time at which the step group was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the step group.
    name: ?[]const u8 = null,

    /// The next step group.
    next: ?[]const []const u8 = null,

    /// The previous step group.
    previous: ?[]const []const u8 = null,

    /// The status of the step group.
    status: ?StepGroupStatus = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    /// List of AWS services utilized in a migration workflow.
    tools: ?[]const Tool = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .next = "next",
        .previous = "previous",
        .status = "status",
        .template_id = "templateId",
        .tools = "tools",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTemplateStepGroupInput, options: CallOptions) !GetTemplateStepGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "migrationhub-orchestrator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTemplateStepGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_id);
    try path_buf.appendSlice(allocator, "/stepgroups/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTemplateStepGroupOutput {
    var result: GetTemplateStepGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTemplateStepGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
