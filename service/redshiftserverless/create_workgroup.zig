const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConfigParameter = @import("config_parameter.zig").ConfigParameter;
const PerformanceTarget = @import("performance_target.zig").PerformanceTarget;
const Tag = @import("tag.zig").Tag;
const Workgroup = @import("workgroup.zig").Workgroup;

pub const CreateWorkgroupInput = struct {
    /// The base data warehouse capacity of the workgroup in Redshift Processing
    /// Units (RPUs).
    base_capacity: ?i32 = null,

    /// An array of parameters to set for advanced control over a database. The
    /// options are `auto_mv`, `datestyle`, `enable_case_sensitive_identifier`,
    /// `enable_user_activity_logging`, `query_group`, `search_path`, `require_ssl`,
    /// `use_fips_ssl`, and either `wlm_json_configuration` or query monitoring
    /// metrics that let you define performance boundaries. You can either specify
    /// individual query monitoring metrics (such as `max_scan_row_count`,
    /// `max_query_execution_time`) or use `wlm_json_configuration` to define query
    /// queues with rules, but not both. If you're using `wlm_json_configuration`,
    /// the maximum size of `parameterValue` is 8000 characters. For more
    /// information about query monitoring rules and available metrics, see [ Query
    /// monitoring metrics for Amazon Redshift
    /// Serverless](https://docs.aws.amazon.com/redshift/latest/dg/cm-c-wlm-query-monitoring-rules.html#cm-c-wlm-query-monitoring-metrics-serverless).
    config_parameters: ?[]const ConfigParameter = null,

    /// The value that specifies whether to turn on enhanced virtual private cloud
    /// (VPC) routing, which forces Amazon Redshift Serverless to route traffic
    /// through your VPC instead of over the internet.
    enhanced_vpc_routing: ?bool = null,

    /// If `true`, allocates additional compute resources for running automatic
    /// optimization operations.
    ///
    /// Default: false
    extra_compute_for_automatic_optimization: ?bool = null,

    /// The IP address type that the workgroup supports. Possible values are `ipv4`
    /// and `dualstack`.
    ip_address_type: ?[]const u8 = null,

    /// The maximum data-warehouse capacity Amazon Redshift Serverless uses to serve
    /// queries. The max capacity is specified in RPUs.
    max_capacity: ?i32 = null,

    /// The name of the namespace to associate with the workgroup.
    namespace_name: []const u8,

    /// The custom port to use when connecting to a workgroup. Valid port ranges are
    /// 5431-5455 and 8191-8215. The default is 5439.
    port: ?i32 = null,

    /// An object that represents the price performance target settings for the
    /// workgroup.
    price_performance_target: ?PerformanceTarget = null,

    /// A value that specifies whether the workgroup can be accessed from a public
    /// network.
    publicly_accessible: ?bool = null,

    /// An array of security group IDs to associate with the workgroup.
    security_group_ids: ?[]const []const u8 = null,

    /// An array of VPC subnet IDs to associate with the workgroup.
    subnet_ids: ?[]const []const u8 = null,

    /// A array of tag instances.
    tags: ?[]const Tag = null,

    /// An optional parameter for the name of the track for the workgroup. If you
    /// don't provide a track name, the workgroup is assigned to the `current`
    /// track.
    track_name: ?[]const u8 = null,

    /// The name of the created workgroup.
    workgroup_name: []const u8,

    pub const json_field_names = .{
        .base_capacity = "baseCapacity",
        .config_parameters = "configParameters",
        .enhanced_vpc_routing = "enhancedVpcRouting",
        .extra_compute_for_automatic_optimization = "extraComputeForAutomaticOptimization",
        .ip_address_type = "ipAddressType",
        .max_capacity = "maxCapacity",
        .namespace_name = "namespaceName",
        .port = "port",
        .price_performance_target = "pricePerformanceTarget",
        .publicly_accessible = "publiclyAccessible",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .track_name = "trackName",
        .workgroup_name = "workgroupName",
    };
};

pub const CreateWorkgroupOutput = struct {
    /// The created workgroup object.
    workgroup: ?Workgroup = null,

    pub const json_field_names = .{
        .workgroup = "workgroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkgroupInput, options: CallOptions) !CreateWorkgroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "redshiftserverless");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkgroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshiftserverless", "Redshift Serverless", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.CreateWorkgroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkgroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWorkgroupOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "DryRunException")) {
        return .{ .arena = arena, .kind = .{ .dry_run_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidPaginationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "Ipv6CidrBlockNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ipv_6_cidr_block_not_found_exception = .{
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
