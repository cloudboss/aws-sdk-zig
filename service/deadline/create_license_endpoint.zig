const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateLicenseEndpointInput = struct {
    /// The unique token which the server uses to recognize retries of the same
    /// request.
    client_token: ?[]const u8 = null,

    /// The security group IDs.
    security_group_ids: []const []const u8,

    /// The subnet IDs.
    subnet_ids: []const []const u8,

    /// Each tag consists of a tag key and a tag value. Tag keys and values are both
    /// required, but tag values can be empty strings.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The VPC (virtual private cloud) ID to use with the license endpoint.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .vpc_id = "vpcId",
    };
};

pub const CreateLicenseEndpointOutput = struct {
    /// The license endpoint ID.
    license_endpoint_id: []const u8,

    pub const json_field_names = .{
        .license_endpoint_id = "licenseEndpointId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLicenseEndpointInput, options: CallOptions) !CreateLicenseEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLicenseEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2023-10-12/license-endpoints";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"securityGroupIds\":");
    try aws.json.writeValue(@TypeOf(input.security_group_ids), input.security_group_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subnetIds\":");
    try aws.json.writeValue(@TypeOf(input.subnet_ids), input.subnet_ids, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"vpcId\":");
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
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Amz-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLicenseEndpointOutput {
    var result: CreateLicenseEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateLicenseEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
