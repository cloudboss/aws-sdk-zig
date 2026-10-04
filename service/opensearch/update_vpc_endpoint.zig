const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCOptions = @import("vpc_options.zig").VPCOptions;
const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;

pub const UpdateVpcEndpointInput = struct {
    /// The unique identifier of the endpoint.
    vpc_endpoint_id: []const u8,

    /// The security groups and/or subnets to add, remove, or modify.
    vpc_options: VPCOptions,

    pub const json_field_names = .{
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_options = "VpcOptions",
    };
};

pub const UpdateVpcEndpointOutput = struct {
    /// The endpoint to be updated.
    vpc_endpoint: ?VpcEndpoint = null,

    pub const json_field_names = .{
        .vpc_endpoint = "VpcEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVpcEndpointInput, options: CallOptions) !UpdateVpcEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVpcEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/vpcEndpoints/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcEndpointId\":");
    try aws.json.writeValue(@TypeOf(input.vpc_endpoint_id), input.vpc_endpoint_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcOptions\":");
    try aws.json.writeValue(@TypeOf(input.vpc_options), input.vpc_options, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVpcEndpointOutput {
    var result: UpdateVpcEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateVpcEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
