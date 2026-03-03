const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GroupConfigurationItem = @import("group_configuration_item.zig").GroupConfigurationItem;
const ResourceQuery = @import("resource_query.zig").ResourceQuery;
const Group = @import("group.zig").Group;
const GroupConfiguration = @import("group_configuration.zig").GroupConfiguration;

pub const CreateGroupInput = struct {
    /// A configuration associates the resource group with an Amazon Web Services
    /// service and specifies how
    /// the service can interact with the resources in the group. A configuration is
    /// an array of
    /// GroupConfigurationItem elements. For details about the syntax of
    /// service configurations, see [Service configurations for Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
    ///
    /// A resource group can contain either a `Configuration` or a
    /// `ResourceQuery`, but not both.
    configuration: ?[]const GroupConfigurationItem = null,

    /// The critical rank of the application group on a scale of 1 to 10, with a
    /// rank of 1 being the most critical, and a rank of 10 being least critical.
    criticality: ?i32 = null,

    /// The description of the resource group. Descriptions can consist of letters,
    /// numbers,
    /// hyphens, underscores, periods, and spaces.
    description: ?[]const u8 = null,

    /// The name of the application group, which you can change at any time.
    display_name: ?[]const u8 = null,

    /// The name of the group, which is the identifier of the group in other
    /// operations. You
    /// can't change the name of a resource group after you create it. A resource
    /// group name can
    /// consist of letters, numbers, hyphens, periods, and underscores. The name
    /// cannot start
    /// with `AWS`, `aws`, or any other possible capitalization; these are
    /// reserved. A resource group name must be unique within each Amazon Web
    /// Services Region in your Amazon Web Services
    /// account.
    name: []const u8,

    /// A name, email address or other identifier for the person or group
    /// who is considered as the owner of this application group within your
    /// organization.
    owner: ?[]const u8 = null,

    /// The resource query that determines which Amazon Web Services resources are
    /// members of this group.
    /// For more information about resource queries, see [Create
    /// a tag-based group in Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted-query.html#gettingstarted-query-cli-tag).
    ///
    /// A resource group can contain either a `ResourceQuery` or a
    /// `Configuration`, but not both.
    resource_query: ?ResourceQuery = null,

    /// The tags to add to the group. A tag is key-value pair string.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .criticality = "Criticality",
        .description = "Description",
        .display_name = "DisplayName",
        .name = "Name",
        .owner = "Owner",
        .resource_query = "ResourceQuery",
        .tags = "Tags",
    };
};

pub const CreateGroupOutput = struct {
    /// The description of the resource group.
    group: ?Group = null,

    /// The service configuration associated with the resource group. For details
    /// about the
    /// syntax of a service configuration, see [Service configurations for Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
    group_configuration: ?GroupConfiguration = null,

    /// The resource query associated with the group. For more information about
    /// resource
    /// queries, see [Create
    /// a tag-based group in Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted-query.html#gettingstarted-query-cli-tag).
    resource_query: ?ResourceQuery = null,

    /// The tags associated with the group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .group = "Group",
        .group_configuration = "GroupConfiguration",
        .resource_query = "ResourceQuery",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGroupInput, options: Options) !CreateGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "resourcegroups");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resourcegroups", "Resource Groups", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/groups";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.criticality) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Criticality\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisplayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Owner\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_query) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceQuery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGroupOutput {
    var result: CreateGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGroupOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MethodNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .method_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
