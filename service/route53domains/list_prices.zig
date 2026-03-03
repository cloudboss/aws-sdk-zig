const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DomainPrice = @import("domain_price.zig").DomainPrice;

pub const ListPricesInput = struct {
    /// For an initial request for a list of prices, omit this element. If the
    /// number of
    /// prices that are not yet complete is greater than the value that you
    /// specified for
    /// `MaxItems`, you can use `Marker` to return additional prices.
    /// Get the value of `NextPageMarker` from the previous response, and submit
    /// another request that includes the value of `NextPageMarker` in the
    /// `Marker` element.
    ///
    /// Used only for all TLDs. If you specify a TLD, don't specify a
    /// `Marker`.
    marker: ?[]const u8 = null,

    /// Number of `Prices` to be returned.
    ///
    /// Used only for all TLDs. If you specify a TLD, don't specify a
    /// `MaxItems`.
    max_items: ?i32 = null,

    /// The TLD for which you want to receive the pricing information. For example.
    /// `.net`.
    ///
    /// If a `Tld` value is not provided, a list of prices for all TLDs supported
    /// by Route 53 is returned.
    tld: ?[]const u8 = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .max_items = "MaxItems",
        .tld = "Tld",
    };
};

pub const ListPricesOutput = struct {
    /// If there are more prices than you specified for `MaxItems` in the request,
    /// submit another request and include the value of `NextPageMarker` in the
    /// value
    /// of `Marker`.
    ///
    /// Used only for all TLDs. If you specify a TLD, don't specify a
    /// `NextPageMarker`.
    next_page_marker: ?[]const u8 = null,

    /// A complex type that includes all the pricing information. If you specify a
    /// TLD, this
    /// array contains only the pricing for that TLD.
    prices: ?[]const DomainPrice = null,

    pub const json_field_names = .{
        .next_page_marker = "NextPageMarker",
        .prices = "Prices",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPricesInput, options: Options) !ListPricesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPricesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.ListPrices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPricesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPricesOutput, body, allocator);
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
