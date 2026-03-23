const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DomainAvailability = @import("domain_availability.zig").DomainAvailability;

pub const CheckDomainAvailabilityInput = struct {
    /// The name of the domain that you want to get availability for. The top-level
    /// domain
    /// (TLD), such as .com, must be a TLD that Route 53 supports. For a list of
    /// supported TLDs,
    /// see [Domains that You Can
    /// Register with Amazon Route
    /// 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar-tld-list.html) in the *Amazon Route 53 Developer
    /// Guide*.
    ///
    /// The domain name can contain only the following characters:
    ///
    /// * Letters a through z. Domain names are not case sensitive.
    ///
    /// * Numbers 0 through 9.
    ///
    /// * Hyphen (-). You can't specify a hyphen at the beginning or end of a label.
    ///
    /// * Period (.) to separate the labels in the name, such as the `.` in
    /// `example.com`.
    ///
    /// Internationalized domain names are not supported for some top-level domains.
    /// To
    /// determine whether the TLD that you want to use supports internationalized
    /// domain names,
    /// see [Domains that You Can
    /// Register with Amazon Route
    /// 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar-tld-list.html). For more information, see [Formatting Internationalized Domain Names](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DomainNameFormat.html#domain-name-format-idns).
    domain_name: []const u8,

    /// Reserved for future use.
    idn_lang_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .idn_lang_code = "IdnLangCode",
    };
};

pub const CheckDomainAvailabilityOutput = struct {
    /// Whether the domain name is available for registering.
    ///
    /// You can register only domains designated as `AVAILABLE`.
    ///
    /// Valid values:
    ///
    /// **AVAILABLE**
    ///
    /// The domain name is available.
    ///
    /// **AVAILABLE_RESERVED**
    ///
    /// The domain name is reserved under specific conditions.
    ///
    /// **AVAILABLE_PREORDER**
    ///
    /// The domain name is available and can be preordered.
    ///
    /// **DONT_KNOW**
    ///
    /// The TLD registry didn't reply with a definitive answer about whether the
    /// domain name is available. Route 53 can return this response for a variety of
    /// reasons, for example, the registry is performing maintenance. Try again
    /// later.
    ///
    /// **INVALID_NAME_FOR_TLD**
    ///
    /// The TLD isn't valid. For example, it can contain characters that aren't
    /// allowed.
    ///
    /// **PENDING**
    ///
    /// The TLD registry didn't return a response in the expected amount of time.
    /// When the response is delayed, it usually takes just a few extra seconds. You
    /// can resubmit the request immediately.
    ///
    /// **RESERVED**
    ///
    /// The domain name has been reserved for another person or
    /// organization.
    ///
    /// **UNAVAILABLE**
    ///
    /// The domain name is not available.
    ///
    /// **UNAVAILABLE_PREMIUM**
    ///
    /// The domain name is not available.
    ///
    /// **UNAVAILABLE_RESTRICTED**
    ///
    /// The domain name is forbidden.
    availability: ?DomainAvailability = null,

    pub const json_field_names = .{
        .availability = "Availability",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckDomainAvailabilityInput, options: CallOptions) !CheckDomainAvailabilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckDomainAvailabilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.CheckDomainAvailability");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckDomainAvailabilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CheckDomainAvailabilityOutput, body, allocator);
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
