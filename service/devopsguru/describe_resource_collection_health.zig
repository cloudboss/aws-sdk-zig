const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceCollectionType = @import("resource_collection_type.zig").ResourceCollectionType;
const CloudFormationHealth = @import("cloud_formation_health.zig").CloudFormationHealth;
const ServiceHealth = @import("service_health.zig").ServiceHealth;
const TagHealth = @import("tag_health.zig").TagHealth;

pub const DescribeResourceCollectionHealthInput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If this value is null, it
    /// retrieves the first page.
    next_token: ?[]const u8 = null,

    /// An Amazon Web Services resource collection type. This type specifies how
    /// analyzed Amazon Web Services resources
    /// are defined. The two types of Amazon Web Services resource collections
    /// supported are Amazon Web Services CloudFormation stacks and
    /// Amazon Web Services resources that contain the same Amazon Web Services tag.
    /// DevOps Guru can be configured to analyze
    /// the Amazon Web Services resources that are defined in the stacks or that are
    /// tagged using the same tag *key*. You can specify up to 500 Amazon Web
    /// Services CloudFormation stacks.
    resource_collection_type: ResourceCollectionType,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_collection_type = "ResourceCollectionType",
    };
};

pub const DescribeResourceCollectionHealthOutput = struct {
    /// The returned `CloudFormationHealthOverview` object that contains an
    /// `InsightHealthOverview` object with the requested system health
    /// information.
    cloud_formation: ?[]const CloudFormationHealth = null,

    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If there are no more pages,
    /// this value is null.
    next_token: ?[]const u8 = null,

    /// An array of `ServiceHealth` objects that describes the health of the Amazon
    /// Web Services
    /// services associated with the resources in the collection.
    service: ?[]const ServiceHealth = null,

    /// The Amazon Web Services tags that are used by resources in the resource
    /// collection.
    ///
    /// Tags help you identify and organize your Amazon Web Services resources. Many
    /// Amazon Web Services services support
    /// tagging, so you can assign the same tag to resources from different services
    /// to indicate
    /// that the resources are related. For example, you can assign the same tag to
    /// an Amazon DynamoDB
    /// table resource that you assign to an Lambda function. For more information
    /// about
    /// using tags, see the [Tagging
    /// best
    /// practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html) whitepaper.
    ///
    /// Each Amazon Web Services tag has two parts.
    ///
    /// * A tag *key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// *keys* are case-sensitive.
    ///
    /// * An optional field known as a tag *value* (for example,
    /// `111122223333`, `Production`, or a team
    /// name). Omitting the tag *value* is the same as using an empty
    /// string. Like tag *keys*, tag *values* are
    /// case-sensitive.
    ///
    /// Together these are known as *key*-*value* pairs.
    ///
    /// The string used for a *key* in a tag that you use to define your resource
    /// coverage must begin with the
    /// prefix `Devops-guru-`. The tag *key* might be
    /// `DevOps-Guru-deployment-application` or
    /// `devops-guru-rds-application`. When you create a *key*, the case of
    /// characters in the *key* can be whatever you choose. After you create a
    /// *key*, it is case-sensitive.
    /// For example, DevOps Guru works with a
    /// *key* named `devops-guru-rds` and a *key* named
    /// `DevOps-Guru-RDS`, and these act as two different *keys*. Possible
    /// *key*/*value* pairs in your
    /// application might be `Devops-Guru-production-application/RDS` or
    /// `Devops-Guru-production-application/containers`.
    tags: ?[]const TagHealth = null,

    pub const json_field_names = .{
        .cloud_formation = "CloudFormation",
        .next_token = "NextToken",
        .service = "Service",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeResourceCollectionHealthInput, options: CallOptions) !DescribeResourceCollectionHealthOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "devops-guru");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeResourceCollectionHealthInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/accounts/health/resource-collection/");
    try path_buf.appendSlice(allocator, input.resource_collection_type);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeResourceCollectionHealthOutput {
    var result: DescribeResourceCollectionHealthOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeResourceCollectionHealthOutput, body, allocator);
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
