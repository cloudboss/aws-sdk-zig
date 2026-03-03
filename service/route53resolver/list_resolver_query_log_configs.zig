const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const SortOrder = @import("sort_order.zig").SortOrder;
const ResolverQueryLogConfig = @import("resolver_query_log_config.zig").ResolverQueryLogConfig;

pub const ListResolverQueryLogConfigsInput = struct {
    /// An optional specification to return a subset of query logging
    /// configurations.
    ///
    /// If you submit a second or subsequent `ListResolverQueryLogConfigs` request
    /// and specify the `NextToken` parameter,
    /// you must use the same values for `Filters`, if any, as in the previous
    /// request.
    filters: ?[]const Filter = null,

    /// The maximum number of query logging configurations that you want to return
    /// in the response to a `ListResolverQueryLogConfigs` request.
    /// If you don't specify a value for `MaxResults`, Resolver returns up to 100
    /// query logging configurations.
    max_results: ?i32 = null,

    /// For the first `ListResolverQueryLogConfigs` request, omit this value.
    ///
    /// If there are more than `MaxResults` query logging configurations that match
    /// the values that you specify for `Filters`,
    /// you can submit another `ListResolverQueryLogConfigs` request to get the next
    /// group of configurations. In the next request, specify the value of
    /// `NextToken` from the previous response.
    next_token: ?[]const u8 = null,

    /// The element that you want Resolver to sort query logging configurations by.
    ///
    /// If you submit a second or subsequent `ListResolverQueryLogConfigs` request
    /// and specify the `NextToken` parameter,
    /// you must use the same value for `SortBy`, if any, as in the previous
    /// request.
    ///
    /// Valid values include the following elements:
    ///
    /// * `Arn`: The ARN of the query logging configuration
    ///
    /// * `AssociationCount`: The number of VPCs that are associated with the
    ///   specified configuration
    ///
    /// * `CreationTime`: The date and time that Resolver returned when the
    ///   configuration was created
    ///
    /// * `CreatorRequestId`: The value that was specified for `CreatorRequestId`
    ///   when the configuration was created
    ///
    /// * `DestinationArn`: The location that logs are sent to
    ///
    /// * `Id`: The ID of the configuration
    ///
    /// * `Name`: The name of the configuration
    ///
    /// * `OwnerId`: The Amazon Web Services account number of the account that
    ///   created the configuration
    ///
    /// * `ShareStatus`: Whether the configuration is shared with other Amazon Web
    ///   Services accounts or shared with the current account by
    /// another Amazon Web Services account. Sharing is configured through Resource
    /// Access Manager (RAM).
    ///
    /// * `Status`: The current status of the configuration. Valid values include
    ///   the following:
    ///
    /// * `CREATING`: Resolver is creating the query logging configuration.
    ///
    /// * `CREATED`: The query logging configuration was successfully created.
    /// Resolver is logging queries that originate in the specified VPC.
    ///
    /// * `DELETING`: Resolver is deleting this query logging configuration.
    ///
    /// * `FAILED`: Resolver either couldn't create or couldn't delete the query
    ///   logging configuration.
    /// Here are two common causes:
    ///
    /// * The specified destination (for example, an Amazon S3 bucket) was deleted.
    ///
    /// * Permissions don't allow sending logs to the destination.
    sort_by: ?[]const u8 = null,

    /// If you specified a value for `SortBy`, the order that you want query logging
    /// configurations to be listed in,
    /// `ASCENDING` or `DESCENDING`.
    ///
    /// If you submit a second or subsequent `ListResolverQueryLogConfigs` request
    /// and specify the `NextToken` parameter,
    /// you must use the same value for `SortOrder`, if any, as in the previous
    /// request.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListResolverQueryLogConfigsOutput = struct {
    /// If there are more than `MaxResults` query logging configurations, you can
    /// submit another `ListResolverQueryLogConfigs` request
    /// to get the next group of configurations. In the next request, specify the
    /// value of `NextToken` from the previous response.
    next_token: ?[]const u8 = null,

    /// A list that contains one `ResolverQueryLogConfig` element for each query
    /// logging configuration that matches the
    /// values that you specified for `Filter`.
    resolver_query_log_configs: ?[]const ResolverQueryLogConfig = null,

    /// The total number of query logging configurations that were created by the
    /// current account in the specified Region. This count can differ from the
    /// number of query logging configurations that are returned in a
    /// `ListResolverQueryLogConfigs` response, depending on the values that you
    /// specify
    /// in the request.
    total_count: ?i32 = null,

    /// The total number of query logging configurations that were created by the
    /// current account in the specified Region and that match the filters
    /// that were specified in the `ListResolverQueryLogConfigs` request. For the
    /// total number of query logging configurations that were created by the
    /// current account in the specified Region, see `TotalCount`.
    total_filtered_count: ?i32 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resolver_query_log_configs = "ResolverQueryLogConfigs",
        .total_count = "TotalCount",
        .total_filtered_count = "TotalFilteredCount",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResolverQueryLogConfigsInput, options: Options) !ListResolverQueryLogConfigsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53resolver");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResolverQueryLogConfigsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.ListResolverQueryLogConfigs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResolverQueryLogConfigsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResolverQueryLogConfigsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidPolicyDocument")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_document = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnknownResourceException")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_exception = .{
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
