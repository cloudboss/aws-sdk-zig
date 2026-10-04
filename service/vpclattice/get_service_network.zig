const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthType = @import("auth_type.zig").AuthType;
const SharingConfig = @import("sharing_config.zig").SharingConfig;

pub const GetServiceNetworkInput = struct {
    /// The ID or ARN of the service network.
    service_network_identifier: []const u8,

    pub const json_field_names = .{
        .service_network_identifier = "serviceNetworkIdentifier",
    };
};

pub const GetServiceNetworkOutput = struct {
    /// The Amazon Resource Name (ARN) of the service network.
    arn: ?[]const u8 = null,

    /// The type of IAM policy.
    auth_type: ?AuthType = null,

    /// The date and time that the service network was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The ID of the service network.
    id: ?[]const u8 = null,

    /// The date and time of the last update, in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The name of the service network.
    name: ?[]const u8 = null,

    /// The number of services associated with the service network.
    number_of_associated_services: ?i64 = null,

    /// The number of VPCs associated with the service network.
    number_of_associated_vp_cs: ?i64 = null,

    /// Specifies if the service network is enabled for sharing.
    sharing_config: ?SharingConfig = null,

    pub const json_field_names = .{
        .arn = "arn",
        .auth_type = "authType",
        .created_at = "createdAt",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .number_of_associated_services = "numberOfAssociatedServices",
        .number_of_associated_vp_cs = "numberOfAssociatedVPCs",
        .sharing_config = "sharingConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceNetworkInput, options: CallOptions) !GetServiceNetworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/servicenetworks/");
    try path_buf.appendSlice(allocator, input.service_network_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceNetworkOutput {
    const result: GetServiceNetworkOutput = try aws.json.parseJsonObject(
        GetServiceNetworkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
