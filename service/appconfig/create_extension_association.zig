const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const CreateExtensionAssociationInput = struct {
    /// The name, the ID, or the Amazon Resource Name (ARN) of the extension.
    extension_identifier: []const u8,

    /// The version number of the extension. If not specified, AppConfig uses the
    /// maximum version of the extension.
    extension_version_number: ?i32 = null,

    /// The parameter names and values defined in the extensions. Extension
    /// parameters marked
    /// `Required` must be entered for this field.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of an application, configuration profile, or environment.
    resource_identifier: []const u8,

    /// Adds one or more tags for the specified extension association. Tags are
    /// metadata that
    /// help you categorize resources in different ways, for example, by purpose,
    /// owner, or
    /// environment. Each tag consists of a key and an optional value, both of which
    /// you define.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .extension_identifier = "ExtensionIdentifier",
        .extension_version_number = "ExtensionVersionNumber",
        .parameters = "Parameters",
        .resource_identifier = "ResourceIdentifier",
        .tags = "Tags",
    };
};

pub const CreateExtensionAssociationOutput = struct {
    /// The system-generated Amazon Resource Name (ARN) for the extension.
    arn: ?[]const u8 = null,

    /// The ARN of the extension defined in the association.
    extension_arn: ?[]const u8 = null,

    /// The version number for the extension defined in the association.
    extension_version_number: i32 = 0,

    /// The system-generated ID for the association.
    id: ?[]const u8 = null,

    /// The parameter names and values defined in the association.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ARNs of applications, configuration profiles, or environments defined in
    /// the
    /// association.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .extension_arn = "ExtensionArn",
        .extension_version_number = "ExtensionVersionNumber",
        .id = "Id",
        .parameters = "Parameters",
        .resource_arn = "ResourceArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExtensionAssociationInput, options: Options) !CreateExtensionAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appconfig");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateExtensionAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/extensionassociations";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ExtensionIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.extension_identifier), input.extension_identifier, alloc, &body_buf);
    has_prev = true;
    if (input.extension_version_number) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ExtensionVersionNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ResourceIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.resource_identifier), input.resource_identifier, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateExtensionAssociationOutput {
    var result: CreateExtensionAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateExtensionAssociationOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "PayloadTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .payload_too_large_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
