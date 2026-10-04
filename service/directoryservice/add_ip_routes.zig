const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpRoute = @import("ip_route.zig").IpRoute;

pub const AddIpRoutesInput = struct {
    /// Identifier (ID) of the directory to which to add the address block.
    directory_id: []const u8,

    /// IP address blocks, using CIDR format, of the traffic to route. This is often
    /// the IP
    /// address block of the DNS server used for your self-managed domain.
    ip_routes: []const IpRoute,

    /// If set to true, updates the inbound and outbound rules of the security group
    /// that has
    /// the description: "Amazon Web Services created security group for *directory
    /// ID*
    /// directory controllers." Following are the new rules:
    ///
    /// Inbound:
    ///
    /// * Type: Custom UDP Rule, Protocol: UDP, Range: 88, Source: Managed Microsoft
    ///   AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom UDP Rule, Protocol: UDP, Range: 123, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom UDP Rule, Protocol: UDP, Range: 138, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom UDP Rule, Protocol: UDP, Range: 389, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom UDP Rule, Protocol: UDP, Range: 464, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom UDP Rule, Protocol: UDP, Range: 445, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom TCP Rule, Protocol: TCP, Range: 88, Source: Managed Microsoft
    ///   AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom TCP Rule, Protocol: TCP, Range: 135, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom TCP Rule, Protocol: TCP, Range: 445, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom TCP Rule, Protocol: TCP, Range: 464, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom TCP Rule, Protocol: TCP, Range: 636, Source: Managed
    ///   Microsoft AD VPC IPv4
    /// CIDR
    ///
    /// * Type: Custom TCP Rule, Protocol: TCP, Range: 1024-65535, Source: Managed
    ///   Microsoft AD VPC
    /// IPv4 CIDR
    ///
    /// * Type: Custom TCP Rule, Protocol: TCP, Range: 3268-33269, Source: Managed
    ///   Microsoft AD VPC
    /// IPv4 CIDR
    ///
    /// * Type: DNS (UDP), Protocol: UDP, Range: 53, Source: Managed Microsoft AD
    ///   VPC IPv4
    /// CIDR
    ///
    /// * Type: DNS (TCP), Protocol: TCP, Range: 53, Source: Managed Microsoft AD
    ///   VPC IPv4
    /// CIDR
    ///
    /// * Type: LDAP, Protocol: TCP, Range: 389, Source: Managed Microsoft AD VPC
    ///   IPv4 CIDR
    ///
    /// * Type: All ICMP, Protocol: All, Range: N/A, Source: Managed Microsoft AD
    ///   VPC IPv4
    /// CIDR
    ///
    /// Outbound:
    ///
    /// * Type: All traffic, Protocol: All, Range: All, Destination: 0.0.0.0/0
    ///
    /// These security rules impact an internal network interface that is not
    /// exposed
    /// publicly.
    update_security_group_for_directory_controllers: ?bool = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .ip_routes = "IpRoutes",
        .update_security_group_for_directory_controllers = "UpdateSecurityGroupForDirectoryControllers",
    };
};

pub const AddIpRoutesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddIpRoutesInput, options: CallOptions) !AddIpRoutesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddIpRoutesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.AddIpRoutes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddIpRoutesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
