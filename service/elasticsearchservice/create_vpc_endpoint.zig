const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCOptions = @import("vpc_options.zig").VPCOptions;
const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;

pub const CreateVpcEndpointInput = struct {
    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the domain to grant access to.
    domain_arn: []const u8,

    /// Options to specify the subnets and security groups for the endpoint.
    vpc_options: VPCOptions,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .domain_arn = "DomainArn",
        .vpc_options = "VpcOptions",
    };
};

pub const CreateVpcEndpointOutput = struct {
    /// Information about the newly created VPC endpoint.
    vpc_endpoint: ?VpcEndpoint = null,

    pub const json_field_names = .{
        .vpc_endpoint = "VpcEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpcEndpointInput, options: CallOptions) !CreateVpcEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpcEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/vpcEndpoints";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DomainArn\":");
    try aws.json.writeValue(@TypeOf(input.domain_arn), input.domain_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpcEndpointOutput {
    const result: CreateVpcEndpointOutput = try aws.json.parseJsonObject(
        CreateVpcEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
