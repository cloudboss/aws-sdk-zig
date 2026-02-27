const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TemplateInput = @import("template_input.zig").TemplateInput;
const TemplateStatus = @import("template_status.zig").TemplateStatus;
const Tool = @import("tool.zig").Tool;

pub const GetTemplateInput = struct {
    /// The ID of the template.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetTemplateOutput = struct {
    /// The time at which the template was last created.
    creation_time: ?i64 = null,

    /// The time at which the template was last created.
    description: ?[]const u8 = null,

    /// The ID of the template.
    id: ?[]const u8 = null,

    /// The inputs provided for the creation of the migration workflow.
    inputs: ?[]const TemplateInput = null,

    /// The name of the template.
    name: ?[]const u8 = null,

    /// The owner of the migration workflow template.
    owner: ?[]const u8 = null,

    /// The status of the template.
    status: ?TemplateStatus = null,

    /// The status message of retrieving migration workflow templates.
    status_message: ?[]const u8 = null,

    /// The tags added to the migration workflow template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// >The Amazon Resource Name (ARN) of the migration workflow template. The
    /// format for an
    /// Migration Hub Orchestrator template ARN is
    /// `arn:aws:migrationhub-orchestrator:region:account:template/template-abcd1234`.
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// in the *AWS General Reference*.
    template_arn: ?[]const u8 = null,

    /// The class of the migration workflow template. The available template classes
    /// are:
    ///
    /// * A2C
    ///
    /// * MGN
    ///
    /// * SAP_MULTI
    ///
    /// * SQL_EC2
    ///
    /// * SQL_RDS
    ///
    /// * VMIE
    template_class: ?[]const u8 = null,

    /// List of AWS services utilized in a migration workflow.
    tools: ?[]const Tool = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .inputs = "inputs",
        .name = "name",
        .owner = "owner",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
        .template_arn = "templateArn",
        .template_class = "templateClass",
        .tools = "tools",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTemplateInput, options: Options) !GetTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "migrationhuborchestrator");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhuborchestrator", "MigrationHubOrchestrator", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/migrationworkflowtemplate/");
    try path_buf.appendSlice(alloc, input.id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetTemplateOutput {
    var result: GetTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTemplateOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
