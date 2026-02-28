const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LayoutConfiguration = @import("layout_configuration.zig").LayoutConfiguration;
const RequiredField = @import("required_field.zig").RequiredField;
const TemplateRule = @import("template_rule.zig").TemplateRule;
const TemplateStatus = @import("template_status.zig").TemplateStatus;
const TagPropagationConfiguration = @import("tag_propagation_configuration.zig").TagPropagationConfiguration;

pub const GetTemplateInput = struct {
    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .template_id = "templateId",
    };
};

pub const GetTemplateOutput = struct {
    /// Timestamp at which the resource was created.
    created_time: ?i64 = null,

    /// Denotes whether or not the resource has been deleted.
    deleted: ?bool = null,

    /// A brief description of the template.
    description: ?[]const u8 = null,

    /// Timestamp at which the resource was created or last modified.
    last_modified_time: ?i64 = null,

    /// Configuration of layouts associated to the template.
    layout_configuration: ?LayoutConfiguration = null,

    /// The name of the template.
    name: []const u8,

    /// A list of fields that must contain a value for a case to be successfully
    /// created with this template.
    required_fields: ?[]const RequiredField = null,

    /// A list of case rules (also known as [case field
    /// conditions](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html)) on a template.
    rules: ?[]const TemplateRule = null,

    /// The status of the template.
    status: TemplateStatus,

    /// Defines tag propagation configuration for resources created within a domain.
    /// Tags specified here will be automatically applied to resources being created
    /// for the specified resource type.
    tag_propagation_configurations: ?[]const TagPropagationConfiguration = null,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the template.
    template_arn: []const u8,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .deleted = "deleted",
        .description = "description",
        .last_modified_time = "lastModifiedTime",
        .layout_configuration = "layoutConfiguration",
        .name = "name",
        .required_fields = "requiredFields",
        .rules = "rules",
        .status = "status",
        .tag_propagation_configurations = "tagPropagationConfigurations",
        .tags = "tags",
        .template_arn = "templateArn",
        .template_id = "templateId",
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "connectcases");

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
    const endpoint = try config.getEndpointForService("connectcases", "ConnectCases", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domains/");
    try path_buf.appendSlice(alloc, input.domain_id);
    try path_buf.appendSlice(alloc, "/templates/");
    try path_buf.appendSlice(alloc, input.template_id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .POST;
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
