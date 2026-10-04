const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpPermission = @import("ip_permission.zig").IpPermission;
const LocationUpdateStatus = @import("location_update_status.zig").LocationUpdateStatus;

pub const DescribeFleetPortSettingsInput = struct {
    /// A unique identifier for the fleet to retrieve port settings for. You can use
    /// either the fleet ID or ARN
    /// value.
    fleet_id: []const u8,

    /// A remote location to check for status of port setting updates. Use the
    /// Amazon Web Services Region
    /// code format, such as `us-west-2`.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .fleet_id = "FleetId",
        .location = "Location",
    };
};

pub const DescribeFleetPortSettingsOutput = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that was requested.
    fleet_id: ?[]const u8 = null,

    /// The port settings for the requested fleet ID.
    inbound_permissions: ?[]const IpPermission = null,

    /// The requested fleet location, expressed as an Amazon Web Services Region
    /// code, such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    /// The current status of updates to the fleet's port settings in the requested
    /// fleet
    /// location. A status of `PENDING_UPDATE` indicates that an update was
    /// requested
    /// for the fleet but has not yet been completed for the location.
    update_status: ?LocationUpdateStatus = null,

    pub const json_field_names = .{
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .inbound_permissions = "InboundPermissions",
        .location = "Location",
        .update_status = "UpdateStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFleetPortSettingsInput, options: CallOptions) !DescribeFleetPortSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFleetPortSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeFleetPortSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFleetPortSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFleetPortSettingsOutput, body, allocator);
}
