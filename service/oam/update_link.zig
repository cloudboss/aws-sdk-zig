const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const LinkConfiguration = @import("link_configuration.zig").LinkConfiguration;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const UpdateLinkInput = struct {
    /// The ARN of the link that you want to update.
    identifier: []const u8,

    /// Specifies whether to include the tags associated with the link in the
    /// response after the update operation. When `IncludeTags` is set to `true` and
    /// the caller has the required permission, `oam:ListTagsForResource`, the API
    /// will return the tags for the specified resource. If the caller doesn't have
    /// the required permission, `oam:ListTagsForResource`, the API will raise an
    /// exception.
    ///
    /// The default value is `false`.
    include_tags: ?bool = null,

    /// Use this structure to filter which metric namespaces and which log groups
    /// are to be shared from the source account to the monitoring account.
    link_configuration: ?LinkConfiguration = null,

    /// An array of strings that define which types of data that the source account
    /// will send to the monitoring account.
    ///
    /// Your input here replaces the current set of data types that are shared.
    resource_types: []const ResourceType,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .include_tags = "IncludeTags",
        .link_configuration = "LinkConfiguration",
        .resource_types = "ResourceTypes",
    };
};

pub const UpdateLinkOutput = struct {
    /// The ARN of the link that you have updated.
    arn: ?[]const u8 = null,

    /// The random ID string that Amazon Web Services generated as part of the sink
    /// ARN.
    id: ?[]const u8 = null,

    /// The label assigned to this link, with the variables resolved to their actual
    /// values.
    label: ?[]const u8 = null,

    /// The exact label template that was specified when the link was created, with
    /// the template variables not resolved.
    label_template: ?[]const u8 = null,

    /// This structure includes filters that specify which metric namespaces and
    /// which log groups are shared from the source account to the monitoring
    /// account.
    link_configuration: ?LinkConfiguration = null,

    /// The resource types now supported by this link.
    resource_types: ?[]const []const u8 = null,

    /// The ARN of the sink that is used for this link.
    sink_arn: ?[]const u8 = null,

    /// The tags assigned to the link.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .label = "Label",
        .label_template = "LabelTemplate",
        .link_configuration = "LinkConfiguration",
        .resource_types = "ResourceTypes",
        .sink_arn = "SinkArn",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLinkInput, options: CallOptions) !UpdateLinkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "oam");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("oam", "OAM", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/UpdateLink";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Identifier\":");
    try aws.json.writeValue(@TypeOf(input.identifier), input.identifier, allocator, &body_buf);
    has_prev = true;
    if (input.include_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.link_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceTypes\":");
    try aws.json.writeValue(@TypeOf(input.resource_types), input.resource_types, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLinkOutput {
    var result: UpdateLinkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateLinkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceFault")) {
        return .{ .arena = arena, .kind = .{ .internal_service_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
