const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GroupByAttribute = @import("group_by_attribute.zig").GroupByAttribute;
const Summary = @import("summary.zig").Summary;

pub const GetComplianceSummaryInput = struct {
    /// Specifies a list of attributes to group the counts of noncompliant resources
    /// by. If
    /// supplied, the counts are sorted by those attributes.
    group_by: ?[]const GroupByAttribute = null,

    /// Specifies the maximum number of results to be returned in each page. A
    /// query can return fewer than this maximum, even if there are more results
    /// still to return. You
    /// should always check the `PaginationToken` response value to see if there are
    /// more
    /// results. You can specify a minimum of 1 and a maximum value of 100.
    max_results: ?i32 = null,

    /// Specifies a `PaginationToken` response value from a
    /// previous request to indicate that you want the next page of results. Leave
    /// this parameter empty
    /// in your initial request.
    pagination_token: ?[]const u8 = null,

    /// Specifies a list of Amazon Web Services Regions to limit the output to. If
    /// you use this parameter,
    /// the count of returned noncompliant resources includes only resources in the
    /// specified
    /// Regions.
    region_filters: ?[]const []const u8 = null,

    /// Specifies that you want the response to include information for only
    /// resources of the
    /// specified types. The format of each resource type is
    /// `service[:resourceType]`. For example, specifying a resource type of
    /// `ec2` returns all Amazon EC2 resources (which includes EC2 instances).
    /// Specifying a resource type of `ec2:instance` returns only EC2
    /// instances.
    ///
    /// The string for each service name and resource type is the same as that
    /// embedded in a
    /// resource's Amazon Resource Name (ARN). Consult the *
    /// [Amazon Web Services General
    /// Reference](https://docs.aws.amazon.com/general/latest/gr/)
    /// *
    /// for the following:
    ///
    /// * For a list of service name strings, see [Amazon Web Services Service
    ///   Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces).
    ///
    /// * For resource type strings, see [Example
    /// ARNs](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arns-syntax).
    ///
    /// * For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    ///
    /// For the list of services whose resources you can tag using the Resource
    /// Groups Tagging API, see
    /// [Services that support the Resource Groups Tagging
    /// API](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/supported-services.html). If an Amazon Web Services
    /// service isn't listed on that page, you might still be able to tag that
    /// service's
    /// resources by using that service's native tagging operations instead of using
    /// Resource Groups Tagging API operations. All tagged resources, whether the
    /// tagging used the Resource Groups Tagging API
    /// or not, are returned by the `Get*` operation.
    ///
    /// You can specify multiple resource types by using a comma separated array.
    /// The array
    /// can include up to 100 items. Note that the length constraint requirement
    /// applies to each
    /// resource type filter.
    resource_type_filters: ?[]const []const u8 = null,

    /// Specifies that you want the response to include information for only
    /// resources that
    /// have tags with the specified tag keys. If you use this parameter, the count
    /// of returned
    /// noncompliant resources includes only resources that have the specified tag
    /// keys.
    tag_key_filters: ?[]const []const u8 = null,

    /// Specifies target identifiers (usually, specific account IDs) to limit the
    /// output by.
    /// If you use this parameter, the count of returned noncompliant resources
    /// includes only
    /// resources with the specified target IDs.
    target_id_filters: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .pagination_token = "PaginationToken",
        .region_filters = "RegionFilters",
        .resource_type_filters = "ResourceTypeFilters",
        .tag_key_filters = "TagKeyFilters",
        .target_id_filters = "TargetIdFilters",
    };
};

pub const GetComplianceSummaryOutput = struct {
    /// A string that indicates that there is more data available than this
    /// response contains. To receive the next part of the response, specify this
    /// response value
    /// as the `PaginationToken` value in the request for the next page.
    pagination_token: ?[]const u8 = null,

    /// A table that shows counts of noncompliant resources.
    summary_list: ?[]const Summary = null,

    pub const json_field_names = .{
        .pagination_token = "PaginationToken",
        .summary_list = "SummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetComplianceSummaryInput, options: CallOptions) !GetComplianceSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "resourcegroupstaggingapi");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetComplianceSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resourcegroupstaggingapi", "Resource Groups Tagging API", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "ResourceGroupsTaggingAPI_20170126.GetComplianceSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComplianceSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetComplianceSummaryOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConstraintViolationException")) {
        return .{ .arena = arena, .kind = .{ .constraint_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
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
    if (std.mem.eql(u8, error_code, "PaginationTokenExpiredException")) {
        return .{ .arena = arena, .kind = .{ .pagination_token_expired_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
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
