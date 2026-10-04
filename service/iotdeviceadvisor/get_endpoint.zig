const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationMethod = @import("authentication_method.zig").AuthenticationMethod;

pub const GetEndpointInput = struct {
    /// The authentication method used during the device connection.
    authentication_method: ?AuthenticationMethod = null,

    /// The certificate ARN of the device. This is an optional parameter.
    certificate_arn: ?[]const u8 = null,

    /// The device role ARN of the device. This is an optional parameter.
    device_role_arn: ?[]const u8 = null,

    /// The thing ARN of the device. This is an optional parameter.
    thing_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_method = "authenticationMethod",
        .certificate_arn = "certificateArn",
        .device_role_arn = "deviceRoleArn",
        .thing_arn = "thingArn",
    };
};

pub const GetEndpointOutput = struct {
    /// The response of an Device Advisor endpoint.
    endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEndpointInput, options: CallOptions) !GetEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotdeviceadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/endpoint";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.authentication_method) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "authenticationMethod=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.certificate_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "certificateArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.device_role_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "deviceRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.thing_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "thingArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEndpointOutput {
    const result: GetEndpointOutput = try aws.json.parseJsonObject(
        GetEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
