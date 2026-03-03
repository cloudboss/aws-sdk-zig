const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContactDetail = @import("contact_detail.zig").ContactDetail;

pub const RegisterDomainInput = struct {
    /// Provides detailed contact information. For information about the values that
    /// you
    /// specify for each element, see
    /// [ContactDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ContactDetail.html).
    admin_contact: ContactDetail,

    /// Indicates whether the domain will be automatically renewed (`true`) or not
    /// (`false`). Auto renewal only takes effect after the account is
    /// charged.
    ///
    /// Default: `true`
    auto_renew: ?bool = null,

    /// Provides detailed contact information. For information about the values that
    /// you
    /// specify for each element, see
    /// [ContactDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ContactDetail.html).
    billing_contact: ?ContactDetail = null,

    /// The domain name that you want to register. The top-level domain (TLD), such
    /// as .com,
    /// must be a TLD that Route 53 supports. For a list of supported TLDs, see
    /// [Domains that You Can Register with Amazon Route
    /// 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar-tld-list.html) in the *Amazon
    /// Route 53 Developer Guide*.
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

    /// The number of years that you want to register the domain for. Domains are
    /// registered
    /// for a minimum of one year. The maximum period depends on the top-level
    /// domain. For the
    /// range of valid values for your domain, see [Domains that You Can
    /// Register with Amazon Route
    /// 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar-tld-list.html) in the *Amazon Route 53 Developer
    /// Guide*.
    ///
    /// Default: 1
    duration_in_years: i32,

    /// Reserved for future use.
    idn_lang_code: ?[]const u8 = null,

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
    ///
    /// Default: `true`
    privacy_protect_admin_contact: ?bool = null,

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
    privacy_protect_billing_contact: ?bool = null,

    /// Whether you want to conceal contact information from WHOIS queries. If you
    /// specify
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If you specify `false`, WHOIS queries return the
    /// information that you entered for the registrant contact (the domain owner).
    ///
    /// You must specify the same privacy setting for the administrative, billing,
    /// registrant, and
    /// technical contacts.
    ///
    /// Default: `true`
    privacy_protect_registrant_contact: ?bool = null,

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
    ///
    /// Default: `true`
    privacy_protect_tech_contact: ?bool = null,

    /// Provides detailed contact information. For information about the values that
    /// you
    /// specify for each element, see
    /// [ContactDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ContactDetail.html).
    registrant_contact: ContactDetail,

    /// Provides detailed contact information. For information about the values that
    /// you
    /// specify for each element, see
    /// [ContactDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ContactDetail.html).
    tech_contact: ContactDetail,

    pub const json_field_names = .{
        .admin_contact = "AdminContact",
        .auto_renew = "AutoRenew",
        .billing_contact = "BillingContact",
        .domain_name = "DomainName",
        .duration_in_years = "DurationInYears",
        .idn_lang_code = "IdnLangCode",
        .privacy_protect_admin_contact = "PrivacyProtectAdminContact",
        .privacy_protect_billing_contact = "PrivacyProtectBillingContact",
        .privacy_protect_registrant_contact = "PrivacyProtectRegistrantContact",
        .privacy_protect_tech_contact = "PrivacyProtectTechContact",
        .registrant_contact = "RegistrantContact",
        .tech_contact = "TechContact",
    };
};

pub const RegisterDomainOutput = struct {
    /// Identifier for tracking the progress of the request. To query the operation
    /// status,
    /// use
    /// [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html).
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterDomainInput, options: CallOptions) !RegisterDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.RegisterDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterDomainOutput, body, allocator);
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
