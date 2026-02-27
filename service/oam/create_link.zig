const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LinkConfiguration = @import("link_configuration.zig").LinkConfiguration;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const CreateLinkInput = struct {
    /// Specify a friendly human-readable name to use to identify this source
    /// account when you are viewing data from it in the monitoring account.
    ///
    /// You can use a custom label or use the following variables:
    ///
    /// * `$AccountName` is the name of the account
    /// * `$AccountEmail` is the globally unique email address of the account
    /// * `$AccountEmailNoDomain` is the email address of the account without the
    ///   domain name
    ///
    /// In the Amazon Web Services GovCloud (US-East) and Amazon Web Services
    /// GovCloud (US-West) Regions, the only supported option is to use custom
    /// labels, and the `$AccountName`, `$AccountEmail`, and `$AccountEmailNoDomain`
    /// variables all resolve as *account-id* instead of the specified variable.
    label_template: []const u8,

    /// Use this structure to optionally create filters that specify that only some
    /// metric namespaces or log groups are to be shared from the source account to
    /// the monitoring account.
    link_configuration: ?LinkConfiguration = null,

    /// An array of strings that define which types of data that the source account
    /// shares with the monitoring account.
    resource_types: []const ResourceType,

    /// The ARN of the sink to use to create this link. You can use
    /// [ListSinks](https://docs.aws.amazon.com/OAM/latest/APIReference/API_ListSinks.html) to find the ARNs of sinks.
    ///
    /// For more information about sinks, see
    /// [CreateSink](https://docs.aws.amazon.com/OAM/latest/APIReference/API_CreateSink.html).
    sink_identifier: []const u8,

    /// Assigns one or more tags (key-value pairs) to the link.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// For more information about using tags to control access, see [Controlling
    /// access to Amazon Web Services resources using
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .label_template = "LabelTemplate",
        .link_configuration = "LinkConfiguration",
        .resource_types = "ResourceTypes",
        .sink_identifier = "SinkIdentifier",
        .tags = "Tags",
    };
};

pub const CreateLinkOutput = struct {
    /// The ARN of the link that is newly created.
    arn: ?[]const u8 = null,

    /// The random ID string that Amazon Web Services generated as part of the link
    /// ARN.
    id: ?[]const u8 = null,

    /// The label that you assigned to this link. If the `labelTemplate` includes
    /// variables, this field displays the variables resolved to their actual
    /// values.
    label: ?[]const u8 = null,

    /// The exact label template that you specified, with the variables not
    /// resolved.
    label_template: ?[]const u8 = null,

    /// This structure includes filters that specify which metric namespaces and
    /// which log groups are shared from the source account to the monitoring
    /// account.
    link_configuration: ?LinkConfiguration = null,

    /// The resource types supported by this link.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLinkInput, options: Options) !CreateLinkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "oam");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("oam", "OAM", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/CreateLink";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"LabelTemplate\":");
    try aws.json.writeValue(@TypeOf(input.label_template), input.label_template, alloc, &body_buf);
    has_prev = true;
    if (input.link_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LinkConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ResourceTypes\":");
    try aws.json.writeValue(@TypeOf(input.resource_types), input.resource_types, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"SinkIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.sink_identifier), input.sink_identifier, alloc, &body_buf);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateLinkOutput {
    var result: CreateLinkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateLinkOutput, body, alloc);
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
