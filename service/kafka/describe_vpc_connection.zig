const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcConnectionState = @import("vpc_connection_state.zig").VpcConnectionState;

pub const DescribeVpcConnectionInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies a MSK VPC
    /// connection.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const DescribeVpcConnectionOutput = struct {
    /// The authentication type of VPC connection.
    authentication: ?[]const u8 = null,

    /// The creation time of the VPC connection.
    creation_time: ?i64 = null,

    /// The list of security groups for the VPC connection.
    security_groups: ?[]const []const u8 = null,

    /// The state of VPC connection.
    state: ?VpcConnectionState = null,

    /// The list of subnets for the VPC connection.
    subnets: ?[]const []const u8 = null,

    /// A map of tags for the VPC connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies an MSK cluster.
    target_cluster_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies a MSK VPC
    /// connection.
    vpc_connection_arn: ?[]const u8 = null,

    /// The VPC Id for the VPC connection.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication = "Authentication",
        .creation_time = "CreationTime",
        .security_groups = "SecurityGroups",
        .state = "State",
        .subnets = "Subnets",
        .tags = "Tags",
        .target_cluster_arn = "TargetClusterArn",
        .vpc_connection_arn = "VpcConnectionArn",
        .vpc_id = "VpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVpcConnectionInput, options: CallOptions) !DescribeVpcConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVpcConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/vpc-connection/");
    try path_buf.appendSlice(allocator, input.arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVpcConnectionOutput {
    const result: DescribeVpcConnectionOutput = try aws.json.parseJsonObject(
        DescribeVpcConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
