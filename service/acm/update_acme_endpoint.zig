const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcmeAuthorizationBehavior = @import("acme_authorization_behavior.zig").AcmeAuthorizationBehavior;
const CertificateAuthority = @import("certificate_authority.zig").CertificateAuthority;
const AcmeContact = @import("acme_contact.zig").AcmeContact;

pub const UpdateAcmeEndpointInput = struct {
    /// The Amazon Resource Name (ARN) of the ACME endpoint to update.
    acme_endpoint_arn: []const u8,

    /// The updated authorization behavior.
    authorization_behavior: ?AcmeAuthorizationBehavior = null,

    /// The updated certificate authority configuration.
    certificate_authority: ?CertificateAuthority = null,

    /// The updated contact requirement.
    contact: ?AcmeContact = null,

    pub const json_field_names = .{
        .acme_endpoint_arn = "AcmeEndpointArn",
        .authorization_behavior = "AuthorizationBehavior",
        .certificate_authority = "CertificateAuthority",
        .contact = "Contact",
    };
};

pub const UpdateAcmeEndpointOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAcmeEndpointInput, options: CallOptions) !UpdateAcmeEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAcmeEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm", "ACM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.UpdateAcmeEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAcmeEndpointOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
