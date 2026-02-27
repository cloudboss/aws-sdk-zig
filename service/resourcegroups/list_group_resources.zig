const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceFilter = @import("resource_filter.zig").ResourceFilter;
const QueryError = @import("query_error.zig").QueryError;
const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;
const ListGroupResourcesItem = @import("list_group_resources_item.zig").ListGroupResourcesItem;

pub const ListGroupResourcesInput = struct {
    /// Filters, formatted as ResourceFilter objects, that you want to apply
    /// to a `ListGroupResources` operation. Filters the results to include only
    /// those of the specified resource types.
    ///
    /// * `resource-type` - Filter resources by their type. Specify up to
    /// five resource types in the format `AWS::ServiceCode::ResourceType`.
    /// For example, `AWS::EC2::Instance`, or `AWS::S3::Bucket`.
    ///
    /// When you specify a `resource-type` filter for
    /// `ListGroupResources`, Resource Groups validates your filter resource types
    /// against the types that are defined in the query associated with the group.
    /// For example,
    /// if a group contains only S3 buckets because its query specifies only that
    /// resource type,
    /// but your `resource-type` filter includes EC2 instances, AWS Resource Groups
    /// does not
    /// filter for EC2 instances. In this case, a `ListGroupResources` request
    /// returns a `BadRequestException` error with a message similar to the
    /// following:
    ///
    /// `The resource types specified as filters in the request are not
    /// valid.`
    ///
    /// The error includes a list of resource types that failed the validation
    /// because they
    /// are not part of the query associated with the group. This validation doesn't
    /// occur when
    /// the group query specifies `AWS::AllSupported`, because a group based on such
    /// a query can contain any of the allowed resource types for the query type
    /// (tag-based or
    /// Amazon CloudFront stack-based queries).
    filters: ?[]const ResourceFilter = null,

    /// The name or the Amazon resource name (ARN) of the resource group.
    group: ?[]const u8 = null,

    /// *
    /// **Deprecated - don't use this parameter. Use the
    /// `Group` request field instead.**
    /// *
    group_name: ?[]const u8 = null,

    /// The total number of results that you want included on each page of the
    /// response. If you do not include this parameter, it defaults to a value that
    /// is specific to the
    /// operation. If additional items exist beyond the maximum you specify, the
    /// `NextToken`
    /// response element is present and has a value (is not null). Include that
    /// value as the
    /// `NextToken` request parameter in the next call to the operation to get the
    /// next part
    /// of the results. Note that the service might return fewer results than the
    /// maximum even when there
    /// are more results available. You should check `NextToken` after every
    /// operation to
    /// ensure that you receive all of the results.
    max_results: ?i32 = null,

    /// The parameter for receiving additional results if you receive a
    /// `NextToken` response in a previous request. A `NextToken` response
    /// indicates that more output is available. Set this parameter to the value
    /// provided by a previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .group = "Group",
        .group_name = "GroupName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListGroupResourcesOutput = struct {
    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    /// A list of `QueryError` objects. Each error contains an
    /// `ErrorCode` and `Message`. Possible values for
    /// ErrorCode are `CLOUDFORMATION_STACK_INACTIVE`,
    /// `CLOUDFORMATION_STACK_NOT_EXISTING`,
    /// `CLOUDFORMATION_STACK_UNASSUMABLE_ROLE` and `RESOURCE_TYPE_NOT_SUPPORTED`.
    query_errors: ?[]const QueryError = null,

    /// **
    /// *Deprecated - don't use this parameter. Use the
    /// `Resources` response field
    /// instead.*
    /// **
    resource_identifiers: ?[]const ResourceIdentifier = null,

    /// An array of resources from which you can determine each resource's identity,
    /// type, and
    /// group membership status.
    resources: ?[]const ListGroupResourcesItem = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .query_errors = "QueryErrors",
        .resource_identifiers = "ResourceIdentifiers",
        .resources = "Resources",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupResourcesInput, options: Options) !ListGroupResourcesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListGroupResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resourcegroups", "Resource Groups", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/list-group-resources";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.group) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Group\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.group_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"GroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"NextToken\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListGroupResourcesOutput {
    var result: ListGroupResourcesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListGroupResourcesOutput, body, alloc);
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
