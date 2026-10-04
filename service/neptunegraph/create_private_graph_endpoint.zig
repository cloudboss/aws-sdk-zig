const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivateGraphEndpointStatus = @import("private_graph_endpoint_status.zig").PrivateGraphEndpointStatus;

pub const CreatePrivateGraphEndpointInput = struct {
    /// The unique identifier of the Neptune Analytics graph.
    graph_identifier: []const u8,

    /// Subnets in which private graph endpoint ENIs are created.
    subnet_ids: ?[]const []const u8 = null,

    /// The VPC in which the private graph endpoint needs to be created.
    vpc_id: ?[]const u8 = null,

    /// Security groups to be attached to the private graph endpoint.
    vpc_security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .graph_identifier = "graphIdentifier",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
    };
};

pub const CreatePrivateGraphEndpointOutput = struct {
    /// Status of the private graph endpoint.
    status: PrivateGraphEndpointStatus,

    /// Subnets in which the private graph endpoint ENIs are created.
    subnet_ids: ?[]const []const u8 = null,

    /// Endpoint ID of the private graph endpoint.
    vpc_endpoint_id: ?[]const u8 = null,

    /// VPC in which the private graph endpoint is created.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePrivateGraphEndpointInput, options: CallOptions) !CreatePrivateGraphEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-graph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePrivateGraphEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/graphs/");
    try path_buf.appendSlice(allocator, input.graph_identifier);
    try path_buf.appendSlice(allocator, "/endpoints/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.subnet_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subnetIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_security_group_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcSecurityGroupIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePrivateGraphEndpointOutput {
    const result: CreatePrivateGraphEndpointOutput = try aws.json.parseJsonObject(
        CreatePrivateGraphEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
