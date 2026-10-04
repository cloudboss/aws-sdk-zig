const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteVpcPeeringAuthorizationInput = struct {
    /// A unique identifier for the Amazon Web Services account that you use to
    /// manage your Amazon GameLift Servers fleet.
    /// You can find your Account ID in the Amazon Web Services Management Console
    /// under account settings.
    game_lift_aws_account_id: []const u8,

    /// A unique identifier for a VPC with resources to be accessed by your Amazon
    /// GameLift Servers fleet. The
    /// VPC must be in the same Region as your fleet. To look up a VPC ID, use the
    /// [VPC Dashboard](https://console.aws.amazon.com/vpc/) in the Amazon Web
    /// Services Management Console.
    /// Learn more about VPC peering in [VPC Peering with Amazon GameLift Servers
    /// Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/vpc-peering.html).
    peer_vpc_id: []const u8,

    pub const json_field_names = .{
        .game_lift_aws_account_id = "GameLiftAwsAccountId",
        .peer_vpc_id = "PeerVpcId",
    };
};

pub const DeleteVpcPeeringAuthorizationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVpcPeeringAuthorizationInput, options: CallOptions) !DeleteVpcPeeringAuthorizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVpcPeeringAuthorizationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DeleteVpcPeeringAuthorization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVpcPeeringAuthorizationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
