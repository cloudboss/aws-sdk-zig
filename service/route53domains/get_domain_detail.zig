const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContactDetail = @import("contact_detail.zig").ContactDetail;
const DnssecKey = @import("dnssec_key.zig").DnssecKey;
const Nameserver = @import("nameserver.zig").Nameserver;

pub const GetDomainDetailInput = struct {
    /// The name of the domain that you want to get detailed information about.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const GetDomainDetailOutput = struct {
    /// Email address to contact to report incorrect contact information for a
    /// domain, to
    /// report that the domain is being used to send spam, to report that someone is
    /// cybersquatting on a domain name, or report some other type of abuse.
    abuse_contact_email: ?[]const u8 = null,

    /// Phone number for reporting abuse.
    abuse_contact_phone: ?[]const u8 = null,

    /// Provides details about the domain administrative contact.
    admin_contact: ?ContactDetail = null,

    /// Specifies whether contact information is concealed from WHOIS queries. If
    /// the value is
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If the value is `false`, WHOIS queries return the
    /// information that you entered for the admin contact.
    admin_privacy: ?bool = null,

    /// Specifies whether the domain registration is set to renew automatically.
    auto_renew: ?bool = null,

    /// Provides details about the domain billing contact.
    billing_contact: ?ContactDetail = null,

    /// Specifies whether contact information is concealed from WHOIS queries. If
    /// the value is
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If the value is `false`, WHOIS queries return the
    /// information that you entered for the billing contact.
    billing_privacy: ?bool = null,

    /// The date when the domain was created as found in the response to a WHOIS
    /// query. The
    /// date and time is in Unix time format and Coordinated Universal time (UTC).
    creation_date: ?i64 = null,

    /// Deprecated.
    dns_sec: ?[]const u8 = null,

    /// A complex type that contains information about the DNSSEC configuration.
    dnssec_keys: ?[]const DnssecKey = null,

    /// The name of a domain.
    domain_name: ?[]const u8 = null,

    /// The date when the registration for the domain is set to expire. The date and
    /// time is
    /// in Unix time format and Coordinated Universal time (UTC).
    expiration_date: ?i64 = null,

    /// The name servers of the domain.
    nameservers: ?[]const Nameserver = null,

    /// Provides details about the domain registrant.
    registrant_contact: ?ContactDetail = null,

    /// Specifies whether contact information is concealed from WHOIS queries. If
    /// the value is
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If the value is `false`, WHOIS queries return the
    /// information that you entered for the registrant contact (domain owner).
    registrant_privacy: ?bool = null,

    /// Name of the registrar of the domain as identified in the registry.
    registrar_name: ?[]const u8 = null,

    /// Web address of the registrar.
    registrar_url: ?[]const u8 = null,

    /// Reserved for future use.
    registry_domain_id: ?[]const u8 = null,

    /// Reseller of the domain. Domains registered or transferred using Route 53
    /// domains will
    /// have `"Amazon"` as the reseller.
    reseller: ?[]const u8 = null,

    /// An array of domain name status codes, also known as Extensible Provisioning
    /// Protocol
    /// (EPP) status codes.
    ///
    /// ICANN, the organization that maintains a central database of domain names,
    /// has
    /// developed a set of domain name status codes that tell you the status of a
    /// variety of
    /// operations on a domain name, for example, registering a domain name,
    /// transferring a
    /// domain name to another registrar, renewing the registration for a domain
    /// name, and so
    /// on. All registrars use this same set of status codes.
    ///
    /// For a current list of domain name status codes and an explanation of what
    /// each code
    /// means, go to the [ICANN website](https://www.icann.org/) and search
    /// for `epp status codes`. (Search on the ICANN website; web searches sometimes
    /// return an old version of the document.)
    status_list: ?[]const []const u8 = null,

    /// Provides details about the domain technical contact.
    tech_contact: ?ContactDetail = null,

    /// Specifies whether contact information is concealed from WHOIS queries. If
    /// the value is
    /// `true`, WHOIS ("who is") queries return contact information either for
    /// Amazon Registrar or for our registrar associate,
    /// Gandi. If the value is `false`, WHOIS queries return the
    /// information that you entered for the technical contact.
    tech_privacy: ?bool = null,

    /// The last updated date of the domain as found in the response to a WHOIS
    /// query. The
    /// date and time is in Unix time format and Coordinated Universal time (UTC).
    updated_date: ?i64 = null,

    /// The fully qualified name of the WHOIS server that can answer the WHOIS query
    /// for the
    /// domain.
    who_is_server: ?[]const u8 = null,

    pub const json_field_names = .{
        .abuse_contact_email = "AbuseContactEmail",
        .abuse_contact_phone = "AbuseContactPhone",
        .admin_contact = "AdminContact",
        .admin_privacy = "AdminPrivacy",
        .auto_renew = "AutoRenew",
        .billing_contact = "BillingContact",
        .billing_privacy = "BillingPrivacy",
        .creation_date = "CreationDate",
        .dns_sec = "DnsSec",
        .dnssec_keys = "DnssecKeys",
        .domain_name = "DomainName",
        .expiration_date = "ExpirationDate",
        .nameservers = "Nameservers",
        .registrant_contact = "RegistrantContact",
        .registrant_privacy = "RegistrantPrivacy",
        .registrar_name = "RegistrarName",
        .registrar_url = "RegistrarUrl",
        .registry_domain_id = "RegistryDomainId",
        .reseller = "Reseller",
        .status_list = "StatusList",
        .tech_contact = "TechContact",
        .tech_privacy = "TechPrivacy",
        .updated_date = "UpdatedDate",
        .who_is_server = "WhoIsServer",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainDetailInput, options: Options) !GetDomainDetailOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetDomainDetailInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "Route53Domains_v20140515.GetDomainDetail");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetDomainDetailOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDomainDetailOutput, body, alloc);
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
