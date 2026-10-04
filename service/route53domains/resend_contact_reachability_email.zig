const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ResendContactReachabilityEmailInput = struct {
    /// The name of the domain for which you want Route 53 to resend a confirmation
    /// email to
    /// the registrant contact.
    domain_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
    };
};

pub const ResendContactReachabilityEmailOutput = struct {
    /// The domain name for which you requested a confirmation email.
    domain_name: ?[]const u8 = null,

    /// The email address for the registrant contact at the time that we sent the
    /// verification
    /// email.
    email_address: ?[]const u8 = null,

    /// `True` if the email address for the registrant contact has already been
    /// verified, and `false` otherwise. If the email address has already been
    /// verified, we don't send another confirmation email.
    is_already_verified: ?bool = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .email_address = "emailAddress",
        .is_already_verified = "isAlreadyVerified",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResendContactReachabilityEmailInput, options: CallOptions) !ResendContactReachabilityEmailOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ResendContactReachabilityEmailInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.ResendContactReachabilityEmail");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResendContactReachabilityEmailOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ResendContactReachabilityEmailOutput, body, allocator);
}
