const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManagedCapacityConfiguration = @import("managed_capacity_configuration.zig").ManagedCapacityConfiguration;

pub const UpdateFleetCapacityInput = struct {
    /// The number of Amazon EC2 instances you want to maintain in the specified
    /// fleet location.
    /// This value must fall between the minimum and maximum size limits. Changes in
    /// desired
    /// instance value can take up to 1 minute to be reflected when viewing the
    /// fleet's capacity
    /// settings.
    desired_instances: ?i32 = null,

    /// A unique identifier for the fleet to update capacity settings for. You can
    /// use either the fleet ID or ARN
    /// value.
    fleet_id: []const u8,

    /// The name of a remote location to update fleet capacity settings for, in the
    /// form of an
    /// Amazon Web Services Region code such as `us-west-2`.
    location: ?[]const u8 = null,

    /// Configuration for Amazon GameLift Servers-managed capacity scaling options.
    managed_capacity_configuration: ?ManagedCapacityConfiguration = null,

    /// The maximum number of instances that are allowed in the specified fleet
    /// location. If
    /// this parameter is not set, the default is 1.
    max_size: ?i32 = null,

    /// The minimum number of instances that are allowed in the specified fleet
    /// location. If
    /// this parameter is not set, the default is 0. This parameter cannot be set
    /// when using a
    /// ManagedCapacityConfiguration where ZeroCapacityStrategy has a value of
    /// SCALE_TO_AND_FROM_ZERO.
    min_size: ?i32 = null,

    pub const json_field_names = .{
        .desired_instances = "DesiredInstances",
        .fleet_id = "FleetId",
        .location = "Location",
        .managed_capacity_configuration = "ManagedCapacityConfiguration",
        .max_size = "MaxSize",
        .min_size = "MinSize",
    };
};

pub const UpdateFleetCapacityOutput = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that was updated.
    fleet_id: ?[]const u8 = null,

    /// The remote location being updated, expressed as an Amazon Web Services
    /// Region code, such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    /// Configuration for Amazon GameLift Servers-managed capacity scaling options.
    managed_capacity_configuration: ?ManagedCapacityConfiguration = null,

    pub const json_field_names = .{
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .location = "Location",
        .managed_capacity_configuration = "ManagedCapacityConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFleetCapacityInput, options: CallOptions) !UpdateFleetCapacityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFleetCapacityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateFleetCapacity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFleetCapacityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFleetCapacityOutput, body, allocator);
}
