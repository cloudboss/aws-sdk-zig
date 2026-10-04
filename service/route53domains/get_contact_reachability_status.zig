const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReachabilityStatus = @import("reachability_status.zig").ReachabilityStatus;

pub const GetContactReachabilityStatusInput = struct {
    /// The name of the domain for which you want to know whether the registrant
    /// contact has
    /// confirmed that the email address is valid.
    domain_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
    };
};

pub const GetContactReachabilityStatusOutput = struct {
    /// The domain name for which you requested the reachability status.
    domain_name: ?[]const u8 = null,

    /// Whether the registrant contact has responded. Values include the following:
    ///
    /// **PENDING**
    ///
    /// We sent the confirmation email and haven't received a response yet.
    ///
    /// **DONE**
    ///
    /// We sent the email and got confirmation from the registrant contact.
    ///
    /// **EXPIRED**
    ///
    /// The time limit expired before the registrant contact responded.
    status: ?ReachabilityStatus = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetContactReachabilityStatusInput, options: CallOptions) !GetContactReachabilityStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetContactReachabilityStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.GetContactReachabilityStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetContactReachabilityStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetContactReachabilityStatusOutput, body, allocator);
}
