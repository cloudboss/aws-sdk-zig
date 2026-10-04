const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConditionalForwarder = @import("conditional_forwarder.zig").ConditionalForwarder;

pub const DescribeConditionalForwardersInput = struct {
    /// The directory ID for which to get the list of associated conditional
    /// forwarders.
    directory_id: []const u8,

    /// The fully qualified domain names (FQDN) of the remote domains for which to
    /// get the list
    /// of associated conditional forwarders. If this member is null, all
    /// conditional forwarders are
    /// returned.
    remote_domain_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .remote_domain_names = "RemoteDomainNames",
    };
};

pub const DescribeConditionalForwardersOutput = struct {
    /// The list of conditional forwarders that have been created.
    conditional_forwarders: ?[]const ConditionalForwarder = null,

    pub const json_field_names = .{
        .conditional_forwarders = "ConditionalForwarders",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConditionalForwardersInput, options: CallOptions) !DescribeConditionalForwardersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConditionalForwardersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeConditionalForwarders");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConditionalForwardersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConditionalForwardersOutput, body, allocator);
}
