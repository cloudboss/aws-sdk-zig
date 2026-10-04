const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcConnectionState = @import("vpc_connection_state.zig").VpcConnectionState;

pub const CreateVpcConnectionInput = struct {
    /// The authentication type of VPC connection.
    authentication: []const u8,

    /// The list of client subnets.
    client_subnets: []const []const u8,

    /// The list of security groups.
    security_groups: []const []const u8,

    /// A map of tags for the VPC connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The cluster Amazon Resource Name (ARN) for the VPC connection.
    target_cluster_arn: []const u8,

    /// The VPC ID of VPC connection.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .authentication = "Authentication",
        .client_subnets = "ClientSubnets",
        .security_groups = "SecurityGroups",
        .tags = "Tags",
        .target_cluster_arn = "TargetClusterArn",
        .vpc_id = "VpcId",
    };
};

pub const CreateVpcConnectionOutput = struct {
    /// The authentication type of VPC connection.
    authentication: ?[]const u8 = null,

    /// The list of client subnets.
    client_subnets: ?[]const []const u8 = null,

    /// The creation time of VPC connection.
    creation_time: ?i64 = null,

    /// The list of security groups.
    security_groups: ?[]const []const u8 = null,

    /// The State of Vpc Connection.
    state: ?VpcConnectionState = null,

    /// A map of tags for the VPC connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The VPC connection ARN.
    vpc_connection_arn: ?[]const u8 = null,

    /// The VPC ID of the VPC connection.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication = "Authentication",
        .client_subnets = "ClientSubnets",
        .creation_time = "CreationTime",
        .security_groups = "SecurityGroups",
        .state = "State",
        .tags = "Tags",
        .vpc_connection_arn = "VpcConnectionArn",
        .vpc_id = "VpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpcConnectionInput, options: CallOptions) !CreateVpcConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpcConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/vpc-connection";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Authentication\":");
    try aws.json.writeValue(@TypeOf(input.authentication), input.authentication, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientSubnets\":");
    try aws.json.writeValue(@TypeOf(input.client_subnets), input.client_subnets, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityGroups\":");
    try aws.json.writeValue(@TypeOf(input.security_groups), input.security_groups, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetClusterArn\":");
    try aws.json.writeValue(@TypeOf(input.target_cluster_arn), input.target_cluster_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcId\":");
    try aws.json.writeValue(@TypeOf(input.vpc_id), input.vpc_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpcConnectionOutput {
    const result: CreateVpcConnectionOutput = try aws.json.parseJsonObject(
        CreateVpcConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
