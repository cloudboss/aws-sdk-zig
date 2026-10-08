const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateConditionalForwarderInput = struct {
    /// The directory ID of the Amazon Web Services directory for which you are
    /// creating the conditional
    /// forwarder.
    directory_id: []const u8,

    /// The IP addresses of the remote DNS server associated with RemoteDomainName.
    dns_ip_addrs: ?[]const []const u8 = null,

    /// The IPv6 addresses of the remote DNS server associated with
    /// RemoteDomainName.
    dns_ipv_6_addrs: ?[]const []const u8 = null,

    /// The fully qualified domain name (FQDN) of the remote domain with which you
    /// will set up
    /// a trust relationship.
    remote_domain_name: []const u8,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .dns_ip_addrs = "DnsIpAddrs",
        .dns_ipv_6_addrs = "DnsIpv6Addrs",
        .remote_domain_name = "RemoteDomainName",
    };
};

pub const CreateConditionalForwarderOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConditionalForwarderInput, options: CallOptions) !CreateConditionalForwarderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConditionalForwarderInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.CreateConditionalForwarder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConditionalForwarderOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
