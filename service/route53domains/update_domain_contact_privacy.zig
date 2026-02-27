const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const UpdateDomainContactPrivacyInput = struct {
    /// Whether you want to conceal contact information from WHOIS queries. If you
    /// specify
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If you specify `false`, WHOIS queries return the
    /// information that you entered for the admin contact.
    ///
    /// You must specify the same privacy setting for the administrative, billing,
    /// registrant, and
    /// technical contacts.
    admin_privacy: ?bool = null,

    /// Whether you want to conceal contact information from WHOIS queries. If you
    /// specify
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If you specify `false`, WHOIS queries return the
    /// information that you entered for the billing contact.
    ///
    /// You must specify the same privacy setting for the administrative, billing,
    /// registrant, and
    /// technical contacts.
    billing_privacy: ?bool = null,

    /// The name of the domain that you want to update the privacy setting for.
    domain_name: []const u8,

    /// Whether you want to conceal contact information from WHOIS queries. If you
    /// specify
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If you specify `false`, WHOIS queries return the
    /// information that you entered for the registrant contact (domain owner).
    ///
    /// You must specify the same privacy setting for the administrative, billing,
    /// registrant, and
    /// technical contacts.
    registrant_privacy: ?bool = null,

    /// Whether you want to conceal contact information from WHOIS queries. If you
    /// specify
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If you specify `false`, WHOIS queries return the
    /// information that you entered for the technical contact.
    ///
    /// You must specify the same privacy setting for the administrative, billing,
    /// registrant, and
    /// technical contacts.
    tech_privacy: ?bool = null,

    pub const json_field_names = .{
        .admin_privacy = "AdminPrivacy",
        .billing_privacy = "BillingPrivacy",
        .domain_name = "DomainName",
        .registrant_privacy = "RegistrantPrivacy",
        .tech_privacy = "TechPrivacy",
    };
};

pub const UpdateDomainContactPrivacyOutput = struct {
    /// Identifier for tracking the progress of the request. To use this ID to query
    /// the
    /// operation status, use GetOperationDetail.
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainContactPrivacyInput, options: Options) !UpdateDomainContactPrivacyOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateDomainContactPrivacyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "Route53Domains_v20140515.UpdateDomainContactPrivacy");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateDomainContactPrivacyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDomainContactPrivacyOutput, body, alloc);
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
