const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsRecordVerificationStatus = @import("dns_record_verification_status.zig").DnsRecordVerificationStatus;
const DnsRecord = @import("dns_record.zig").DnsRecord;

pub const GetMailDomainInput = struct {
    /// The domain from which you want to retrieve details.
    domain_name: []const u8,

    /// The WorkMail organization for which the domain is retrieved.
    organization_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .organization_id = "OrganizationId",
    };
};

pub const GetMailDomainOutput = struct {
    /// Indicates the status of a DKIM verification.
    dkim_verification_status: ?DnsRecordVerificationStatus = null,

    /// Specifies whether the domain is the default domain for your organization.
    is_default: ?bool = null,

    /// Specifies whether the domain is a test domain provided by WorkMail, or a
    /// custom domain.
    is_test_domain: ?bool = null,

    /// Indicates the status of the domain ownership verification.
    ownership_verification_status: ?DnsRecordVerificationStatus = null,

    /// A list of the DNS records that WorkMail recommends adding in your DNS
    /// provider for the best user experience. The records configure your domain
    /// with DMARC, SPF, DKIM, and direct incoming
    /// email traffic to SES. See admin guide for more details.
    records: ?[]const DnsRecord = null,

    pub const json_field_names = .{
        .dkim_verification_status = "DkimVerificationStatus",
        .is_default = "IsDefault",
        .is_test_domain = "IsTestDomain",
        .ownership_verification_status = "OwnershipVerificationStatus",
        .records = "Records",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMailDomainInput, options: CallOptions) !GetMailDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMailDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.GetMailDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMailDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMailDomainOutput, body, allocator);
}
