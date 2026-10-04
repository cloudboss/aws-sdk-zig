const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceProfile = @import("instance_profile.zig").InstanceProfile;

pub const GetInstanceProfileInput = struct {
    /// The Amazon Resource Name (ARN) of an instance profile.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const GetInstanceProfileOutput = struct {
    /// An object that contains information about an instance profile.
    instance_profile: ?InstanceProfile = null,

    pub const json_field_names = .{
        .instance_profile = "instanceProfile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstanceProfileInput, options: CallOptions) !GetInstanceProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstanceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.GetInstanceProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstanceProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInstanceProfileOutput, body, allocator);
}
