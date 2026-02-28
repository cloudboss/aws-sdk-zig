const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CustomDomain = @import("custom_domain.zig").CustomDomain;
const VpcDNSTarget = @import("vpc_dns_target.zig").VpcDNSTarget;

pub const DescribeCustomDomainsInput = struct {
    /// The maximum number of results that each response (result page) can include.
    /// It's used for a paginated request.
    ///
    /// If you don't specify `MaxResults`, the request retrieves all available
    /// results in a single response.
    max_results: ?i32 = null,

    /// A token from a previous result page. It's used for a paginated request. The
    /// request retrieves the next result page. All other parameter values must be
    /// identical to the ones that are specified in the initial request.
    ///
    /// If you don't specify `NextToken`, the request retrieves the first result
    /// page.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the App Runner service that you want
    /// associated custom domain names to be described for.
    service_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_arn = "ServiceArn",
    };
};

pub const DescribeCustomDomainsOutput = struct {
    /// A list of descriptions of custom domain names that are associated with the
    /// service. In a paginated request, the request returns up to
    /// `MaxResults` records per call.
    custom_domains: ?[]const CustomDomain = null,

    /// The App Runner subdomain of the App Runner service. The associated custom
    /// domain names are mapped to this target name.
    dns_target: []const u8,

    /// The token that you can pass in a subsequent request to get the next result
    /// page. It's returned in a paginated request.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the App Runner service whose associated
    /// custom domain names you want to describe.
    service_arn: []const u8,

    /// DNS Target records for the custom domains of this Amazon VPC.
    vpc_dns_targets: ?[]const VpcDNSTarget = null,

    pub const json_field_names = .{
        .custom_domains = "CustomDomains",
        .dns_target = "DNSTarget",
        .next_token = "NextToken",
        .service_arn = "ServiceArn",
        .vpc_dns_targets = "VpcDNSTargets",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCustomDomainsInput, options: Options) !DescribeCustomDomainsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apprunner");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeCustomDomainsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apprunner", "AppRunner", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AppRunner.DescribeCustomDomains");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeCustomDomainsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeCustomDomainsOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
