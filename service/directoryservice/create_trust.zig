const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SelectiveAuth = @import("selective_auth.zig").SelectiveAuth;
const TrustDirection = @import("trust_direction.zig").TrustDirection;
const TrustType = @import("trust_type.zig").TrustType;

pub const CreateTrustInput = struct {
    /// The IP addresses of the remote DNS server associated with RemoteDomainName.
    conditional_forwarder_ip_addrs: ?[]const []const u8 = null,

    /// The IPv6 addresses of the remote DNS server associated with
    /// RemoteDomainName.
    conditional_forwarder_ipv_6_addrs: ?[]const []const u8 = null,

    /// The Directory ID of the Managed Microsoft AD directory for which to
    /// establish the trust
    /// relationship.
    directory_id: []const u8,

    /// The Fully Qualified Domain Name (FQDN) of the external domain for which to
    /// create the
    /// trust relationship.
    remote_domain_name: []const u8,

    /// Optional parameter to enable selective authentication for the trust.
    selective_auth: ?SelectiveAuth = null,

    /// The direction of the trust relationship.
    trust_direction: TrustDirection,

    /// The trust password. The trust password must be the same password that was
    /// used when creating the trust
    /// relationship on the external domain.
    trust_password: []const u8,

    /// The trust relationship type. `Forest` is the default.
    trust_type: ?TrustType = null,

    pub const json_field_names = .{
        .conditional_forwarder_ip_addrs = "ConditionalForwarderIpAddrs",
        .conditional_forwarder_ipv_6_addrs = "ConditionalForwarderIpv6Addrs",
        .directory_id = "DirectoryId",
        .remote_domain_name = "RemoteDomainName",
        .selective_auth = "SelectiveAuth",
        .trust_direction = "TrustDirection",
        .trust_password = "TrustPassword",
        .trust_type = "TrustType",
    };
};

pub const CreateTrustOutput = struct {
    /// A unique identifier for the trust relationship that was created.
    trust_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .trust_id = "TrustId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrustInput, options: CallOptions) !CreateTrustOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrustInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.CreateTrust");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrustOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTrustOutput, body, allocator);
}
