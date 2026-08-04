const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainContactPrivacyInput, options: CallOptions) !UpdateDomainContactPrivacyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53domains", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainContactPrivacyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.UpdateDomainContactPrivacy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainContactPrivacyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDomainContactPrivacyOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.DnssecLimitExceeded = aws.json.parseJsonObject(errors.DnssecLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dnssec_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainLimitExceeded")) {
        const parsed_error: ?errors.DomainLimitExceeded = aws.json.parseJsonObject(errors.DomainLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequest")) {
        const parsed_error: ?errors.DuplicateRequest = aws.json.parseJsonObject(errors.DuplicateRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        const parsed_error: ?errors.InvalidInput = aws.json.parseJsonObject(errors.InvalidInput, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationLimitExceeded")) {
        const parsed_error: ?errors.OperationLimitExceeded = aws.json.parseJsonObject(errors.OperationLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TLDInMaintenance")) {
        const parsed_error: ?errors.TLDInMaintenance = aws.json.parseJsonObject(errors.TLDInMaintenance, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tld_in_maintenance = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TLDRulesViolation")) {
        const parsed_error: ?errors.TLDRulesViolation = aws.json.parseJsonObject(errors.TLDRulesViolation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tld_rules_violation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedTLD")) {
        const parsed_error: ?errors.UnsupportedTLD = aws.json.parseJsonObject(errors.UnsupportedTLD, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_tld = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
