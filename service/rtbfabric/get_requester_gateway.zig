const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequesterGatewayStatus = @import("requester_gateway_status.zig").RequesterGatewayStatus;

pub const GetRequesterGatewayInput = struct {
    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
    };
};

pub const GetRequesterGatewayOutput = struct {
    /// The count of active links for the requester gateway.
    active_links_count: ?i32 = null,

    /// The timestamp of when the requester gateway was created.
    created_at: ?i64 = null,

    /// The description of the requester gateway.
    description: ?[]const u8 = null,

    /// The domain name of the requester gateway.
    domain_name: []const u8,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifiers of the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The status of the request.
    status: RequesterGatewayStatus,

    /// The unique identifiers of the subnets.
    subnet_ids: ?[]const []const u8 = null,

    /// A map of the key-value pairs for the tag or tags assigned to the specified
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The total count of links for the requester gateway.
    total_links_count: ?i32 = null,

    /// The timestamp of when the requester gateway was updated.
    updated_at: ?i64 = null,

    /// The unique identifier of the Virtual Private Cloud (VPC).
    vpc_id: []const u8,

    pub const json_field_names = .{
        .active_links_count = "activeLinksCount",
        .created_at = "createdAt",
        .description = "description",
        .domain_name = "domainName",
        .gateway_id = "gatewayId",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .total_links_count = "totalLinksCount",
        .updated_at = "updatedAt",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRequesterGatewayInput, options: CallOptions) !GetRequesterGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rtbfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRequesterGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/requester-gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRequesterGatewayOutput {
    const result: GetRequesterGatewayOutput = try aws.json.parseJsonObject(
        GetRequesterGatewayOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
