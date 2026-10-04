const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateAwsTrainingCertificationEmailDomainInput = struct {
    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The email address used to verify domain ownership for AWS training and
    /// certification association.
    email: []const u8,

    /// The verification code sent to the email address to confirm domain ownership.
    email_verification_code: []const u8,

    /// The unique identifier of the partner account.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .email = "Email",
        .email_verification_code = "EmailVerificationCode",
        .identifier = "Identifier",
    };
};

pub const AssociateAwsTrainingCertificationEmailDomainOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateAwsTrainingCertificationEmailDomainInput, options: CallOptions) !AssociateAwsTrainingCertificationEmailDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateAwsTrainingCertificationEmailDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.AssociateAwsTrainingCertificationEmailDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateAwsTrainingCertificationEmailDomainOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
