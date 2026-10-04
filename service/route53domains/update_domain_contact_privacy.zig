const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
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
