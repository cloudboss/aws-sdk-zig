const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainTransferability = @import("domain_transferability.zig").DomainTransferability;

pub const CheckDomainTransferabilityInput = struct {
    /// If the registrar for the top-level domain (TLD) requires an authorization
    /// code to
    /// transfer the domain, the code that you got from the current registrar for
    /// the
    /// domain.
    auth_code: ?[]const u8 = null,

    /// The name of the domain that you want to transfer to Route 53. The top-level
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
    domain_name: []const u8,

    pub const json_field_names = .{
        .auth_code = "AuthCode",
        .domain_name = "DomainName",
    };
};

pub const CheckDomainTransferabilityOutput = struct {
    /// Provides an explanation for when a domain can't be transferred.
    message: ?[]const u8 = null,

    /// A complex type that contains information about whether the specified domain
    /// can be
    /// transferred to Route 53.
    transferability: ?DomainTransferability = null,

    pub const json_field_names = .{
        .message = "Message",
        .transferability = "Transferability",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckDomainTransferabilityInput, options: CallOptions) !CheckDomainTransferabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckDomainTransferabilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.CheckDomainTransferability");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckDomainTransferabilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CheckDomainTransferabilityOutput, body, allocator);
}
