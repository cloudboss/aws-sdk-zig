const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FilterCondition = @import("filter_condition.zig").FilterCondition;
const SortCondition = @import("sort_condition.zig").SortCondition;
const DomainSummary = @import("domain_summary.zig").DomainSummary;

pub const ListDomainsInput = struct {
    /// A complex type that contains information about the filters applied during
    /// the
    /// `ListDomains` request. The filter conditions can include domain name and
    /// domain expiration.
    filter_conditions: ?[]const FilterCondition = null,

    /// For an initial request for a list of domains, omit this element. If the
    /// number of
    /// domains that are associated with the current Amazon Web Services account is
    /// greater than
    /// the value that you specified for `MaxItems`, you can use `Marker`
    /// to return additional domains. Get the value of `NextPageMarker` from the
    /// previous response, and submit another request that includes the value of
    /// `NextPageMarker` in the `Marker` element.
    ///
    /// Constraints: The marker must match the value specified in the previous
    /// request.
    marker: ?[]const u8 = null,

    /// Number of domains to be returned.
    ///
    /// Default: 20
    max_items: ?i32 = null,

    /// A complex type that contains information about the requested ordering of
    /// domains in
    /// the returned list.
    sort_condition: ?SortCondition = null,

    pub const json_field_names = .{
        .filter_conditions = "FilterConditions",
        .marker = "Marker",
        .max_items = "MaxItems",
        .sort_condition = "SortCondition",
    };
};

pub const ListDomainsOutput = struct {
    /// A list of domains.
    domains: ?[]const DomainSummary = null,

    /// If there are more domains than you specified for `MaxItems` in the request,
    /// submit another request and include the value of `NextPageMarker` in the
    /// value
    /// of `Marker`.
    next_page_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .domains = "Domains",
        .next_page_marker = "NextPageMarker",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDomainsInput, options: Options) !ListDomainsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53domains");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDomainsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.ListDomains");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDomainsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDomainsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "DnssecLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .dnssec_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .domain_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequest")) {
        return .{ .arena = arena, .kind = .{ .duplicate_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        return .{ .arena = arena, .kind = .{ .invalid_input = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .operation_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TLDRulesViolation")) {
        return .{ .arena = arena, .kind = .{ .tld_rules_violation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedTLD")) {
        return .{ .arena = arena, .kind = .{ .unsupported_tld = .{
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
