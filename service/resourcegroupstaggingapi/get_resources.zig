const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagFilter = @import("tag_filter.zig").TagFilter;
const ResourceTagMapping = @import("resource_tag_mapping.zig").ResourceTagMapping;

pub const GetResourcesInput = struct {
    /// Specifies whether to exclude resources that are compliant with the tag
    /// policy. Set
    /// this to `true` if you are interested in retrieving information on
    /// noncompliant resources only.
    ///
    /// You can use this parameter only if the `IncludeComplianceDetails` parameter
    /// is also set to `true`.
    exclude_compliant_resources: ?bool = null,

    /// Specifies whether to include details regarding the compliance with the
    /// effective tag
    /// policy. Set this to `true` to determine whether resources are compliant with
    /// the tag policy and to get details.
    include_compliance_details: ?bool = null,

    /// Specifies a `PaginationToken` response value from a
    /// previous request to indicate that you want the next page of results. Leave
    /// this parameter empty
    /// in your initial request.
    pagination_token: ?[]const u8 = null,

    /// Specifies a list of ARNs of resources for which you want to retrieve tag
    /// data.
    ///
    /// You can't specify both this parameter and the `ResourceTypeFilters`
    /// parameter in the same request. If you do, you get an `Invalid Parameter`
    /// exception.
    ///
    /// You can't specify both this parameter and the `TagFilters` parameter in the
    /// same request. If you do, you get an `Invalid Parameter` exception.
    ///
    /// You can't specify both this parameter and any of the pagination parameters
    /// (`ResourcesPerPage`, `TagsPerPage`,
    /// `PaginationToken`) in the same request. If you do, you get an
    /// `Invalid Parameter` exception.
    ///
    /// If a resource specified by this parameter doesn't exist, it doesn't generate
    /// an error;
    /// it simply isn't included in the response.
    ///
    /// An ARN (Amazon Resource Name) uniquely identifies a resource. For more
    /// information,
    /// see [Amazon
    /// Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference*.
    resource_arn_list: ?[]const []const u8 = null,

    /// Specifies the maximum number of results to be returned in each page. A
    /// query can return fewer than this maximum, even if there are more results
    /// still to return. You
    /// should always check the `PaginationToken` response value to see if there are
    /// more
    /// results. You can specify a minimum of 1 and a maximum value of 100.
    resources_per_page: ?i32 = null,

    /// Specifies the resource types that you want included in the response. The
    /// format of
    /// each resource type is `service[:resourceType]`. For example, specifying a
    /// service of `ec2` returns all Amazon EC2 resources (which includes EC2
    /// instances).
    /// Specifying a resource type of `ec2:instance` returns only EC2 instances.
    ///
    /// You can't specify both this parameter and the `ResourceArnList` parameter
    /// in the same request. If you do, you get an `Invalid Parameter`
    /// exception.
    ///
    /// The string for each service name and resource type is the same as that
    /// embedded in a
    /// resource's Amazon Resource Name (ARN).
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
    /// You can specify multiple resource types by using an array. The array can
    /// include up to
    /// 100 items. Note that the length constraint requirement applies to each
    /// resource type
    /// filter. For example, the following string would limit the response to only
    /// Amazon EC2
    /// instances, Amazon S3 buckets, or any Audit Manager resource:
    ///
    /// `ec2:instance,s3:bucket,auditmanager`
    resource_type_filters: ?[]const []const u8 = null,

    /// Specifies a list of TagFilters (keys and values) to restrict the output to
    /// only those
    /// resources that have tags with the specified keys and, if included, the
    /// specified values.
    /// Each `TagFilter` must contain a key with values optional. A request can
    /// include up to 50 keys, and each key can include up to 20 values.
    ///
    /// You can't specify both this parameter and the `ResourceArnList` parameter
    /// in the same request. If you do, you get an `Invalid Parameter`
    /// exception.
    ///
    /// Note the following when deciding how to use TagFilters:
    ///
    /// * If you *don't* specify a `TagFilter`, the
    /// response includes all resources that are currently tagged or ever had a tag.
    /// Resources that were previously tagged, *but do not currently*
    /// have tags, are shown with an empty tag set, like this: `"Tags":
    /// []`.
    ///
    /// * If you specify more than one filter in a single request, the response
    ///   returns
    /// only those resources that satisfy all filters.
    ///
    /// * If you specify a filter that contains more than one value for a key, the
    /// response returns resources that match *any* of the specified
    /// values for that key.
    ///
    /// * If you don't specify a value for a key, the response returns all resources
    /// that are tagged with that key, with any or no value.
    ///
    /// For example, for the following filters: `filter1= {key1,{value1}}`,
    /// `filter2={key2,{value2,value3,value4}}`, `filter3=
    /// {key3}`:
    ///
    /// * `GetResources({filter1})` returns resources tagged with
    /// `key1=value1`
    ///
    /// * `GetResources({filter2})` returns resources tagged with
    /// `key2=value2` or `key2=value3` or
    /// `key2=value4`
    ///
    /// * `GetResources({filter3})` returns resources tagged with any
    /// tag with the key `key3`, and with any or no value
    ///
    /// * `GetResources({filter1,filter2,filter3})` returns resources
    /// tagged with `(key1=value1) and (key2=value2 or key2=value3 or
    /// key2=value4) and (key3, any or no value)`
    tag_filters: ?[]const TagFilter = null,

    /// Amazon Web Services recommends using `ResourcesPerPage` instead of this
    /// parameter.
    ///
    /// A limit that restricts the number of tags (key and value pairs) returned by
    /// `GetResources` in paginated output. A resource with no tags is counted as
    /// having one tag (one key and value pair).
    ///
    /// `GetResources` does not split a resource and its associated tags across
    /// pages. If the specified `TagsPerPage` would cause such a break, a
    /// `PaginationToken` is returned in place of the affected resource and its
    /// tags. Use that token in another request to get the remaining data. For
    /// example, if you
    /// specify a `TagsPerPage` of `100` and the account has 22 resources
    /// with 10 tags each (meaning that each resource has 10 key and value pairs),
    /// the output
    /// will consist of three pages. The first page displays the first 10 resources,
    /// each with
    /// its 10 tags. The second page displays the next 10 resources, each with its
    /// 10 tags. The
    /// third page displays the remaining 2 resources, each with its 10 tags.
    ///
    /// You can set `TagsPerPage` to a minimum of 100 items up to a maximum of 500
    /// items.
    tags_per_page: ?i32 = null,

    pub const json_field_names = .{
        .exclude_compliant_resources = "ExcludeCompliantResources",
        .include_compliance_details = "IncludeComplianceDetails",
        .pagination_token = "PaginationToken",
        .resource_arn_list = "ResourceARNList",
        .resources_per_page = "ResourcesPerPage",
        .resource_type_filters = "ResourceTypeFilters",
        .tag_filters = "TagFilters",
        .tags_per_page = "TagsPerPage",
    };
};

pub const GetResourcesOutput = struct {
    /// A string that indicates that there is more data available than this
    /// response contains. To receive the next part of the response, specify this
    /// response value
    /// as the `PaginationToken` value in the request for the next page.
    pagination_token: ?[]const u8 = null,

    /// A list of resource ARNs and the tags (keys and values) associated with
    /// each.
    resource_tag_mapping_list: ?[]const ResourceTagMapping = null,

    pub const json_field_names = .{
        .pagination_token = "PaginationToken",
        .resource_tag_mapping_list = "ResourceTagMappingList",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourcesInput, options: Options) !GetResourcesOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resourcegroupstaggingapi", "Resource Groups Tagging API", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "ResourceGroupsTaggingAPI_20170126.GetResources");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourcesOutput, body, alloc);
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
