const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceQuery = @import("resource_query.zig").ResourceQuery;

pub const StartTagSyncTaskInput = struct {
    /// The Amazon resource name (ARN) or name of the application group for which
    /// you want to create a tag-sync task.
    group: []const u8,

    /// The query you can use to create the tag-sync task. With this method, all
    /// resources matching the query
    /// are added to the specified application group. A
    /// `ResourceQuery` specifies both a query `Type` and a
    /// `Query` string as JSON string objects. For more information on defining a
    /// resource query for a
    /// tag-sync task, see the tag-based query type in [
    /// Types of resource group
    /// queries](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted-query.html#getting_started-query_types) in *Resource Groups User Guide*.
    ///
    /// When using the `ResourceQuery` parameter, you cannot use the `TagKey` and
    /// `TagValue` parameters.
    ///
    /// When you combine all of the elements together into a single string, any
    /// double quotes
    /// that are embedded inside another double quote pair must be escaped by
    /// preceding the
    /// embedded double quote with a backslash character (\). For example, a
    /// complete
    /// `ResourceQuery` parameter must be formatted like the following CLI
    /// parameter example:
    ///
    /// `--resource-query
    /// '{"Type":"TAG_FILTERS_1_0","Query":"{\"ResourceTypeFilters\":[\"AWS::AllSupported\"],\"TagFilters\":[{\"Key\":\"Stage\",\"Values\":[\"Test\"]}]}"}'`
    ///
    /// In the preceding example, all of the double quote characters in the value
    /// part of the
    /// `Query` element must be escaped because the value itself is surrounded by
    /// double quotes. For more information, see [Quoting
    /// strings](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-quoting-strings.html) in the *Command Line Interface User Guide*.
    ///
    /// For the complete list of resource types that you can use in the array value
    /// for
    /// `ResourceTypeFilters`, see [Resources
    /// you can use with Resource Groups and Tag
    /// Editor](https://docs.aws.amazon.com/ARG/latest/userguide/supported-resources.html) in the
    /// *Resource Groups User Guide*. For example:
    ///
    /// `"ResourceTypeFilters":["AWS::S3::Bucket", "AWS::EC2::Instance"]`
    resource_query: ?ResourceQuery = null,

    /// The Amazon resource name (ARN) of the role assumed by the service to tag and
    /// untag resources on your behalf.
    role_arn: []const u8,

    /// The tag key. Resources tagged with this tag key-value pair will be added to
    /// the application. If a resource with this tag is later untagged, the tag-sync
    /// task removes
    /// the resource from the application.
    ///
    /// When using the `TagKey` parameter, you must also specify the `TagValue`
    /// parameter. If you specify a tag key-value pair,
    /// you can't use the `ResourceQuery` parameter.
    tag_key: ?[]const u8 = null,

    /// The tag value. Resources tagged with this tag key-value pair will be added
    /// to
    /// the application. If a resource with this tag is later untagged, the tag-sync
    /// task removes
    /// the resource from the application.
    ///
    /// When using the `TagValue` parameter, you must also specify the `TagKey`
    /// parameter. If you specify a tag key-value pair,
    /// you can't use the `ResourceQuery` parameter.
    tag_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .group = "Group",
        .resource_query = "ResourceQuery",
        .role_arn = "RoleArn",
        .tag_key = "TagKey",
        .tag_value = "TagValue",
    };
};

pub const StartTagSyncTaskOutput = struct {
    /// The Amazon resource name (ARN) of the application group for which you want
    /// to add or remove resources.
    group_arn: ?[]const u8 = null,

    /// The name of the application group to onboard and sync resources.
    group_name: ?[]const u8 = null,

    resource_query: ?ResourceQuery = null,

    /// The Amazon resource name (ARN) of the role assumed by the service to tag and
    /// untag resources on your behalf.
    role_arn: ?[]const u8 = null,

    /// The tag key of the tag-sync task.
    tag_key: ?[]const u8 = null,

    /// The tag value of the tag-sync task.
    tag_value: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of the new tag-sync task.
    task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_arn = "GroupArn",
        .group_name = "GroupName",
        .resource_query = "ResourceQuery",
        .role_arn = "RoleArn",
        .tag_key = "TagKey",
        .tag_value = "TagValue",
        .task_arn = "TaskArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTagSyncTaskInput, options: Options) !StartTagSyncTaskOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartTagSyncTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resourcegroups", "Resource Groups", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/start-tag-sync-task";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Group\":");
    try aws.json.writeValue(@TypeOf(input.group), input.group, alloc, &body_buf);
    has_prev = true;
    if (input.resource_query) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ResourceQuery\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (input.tag_key) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TagKey\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tag_value) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TagValue\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartTagSyncTaskOutput {
    var result: StartTagSyncTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartTagSyncTaskOutput, body, alloc);
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
