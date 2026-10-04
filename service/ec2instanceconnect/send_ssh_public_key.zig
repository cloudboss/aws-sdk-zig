const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendSSHPublicKeyInput = struct {
    /// The Availability Zone in which the EC2 instance was launched.
    availability_zone: ?[]const u8 = null,

    /// The ID of the EC2 instance.
    instance_id: []const u8,

    /// The OS user on the EC2 instance for whom the key can be used to
    /// authenticate.
    instance_os_user: []const u8,

    /// The public key material. To use the public key, you must have the matching
    /// private key.
    ssh_public_key: []const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .instance_id = "InstanceId",
        .instance_os_user = "InstanceOSUser",
        .ssh_public_key = "SSHPublicKey",
    };
};

pub const SendSSHPublicKeyOutput = struct {
    /// The ID of the request. Please provide this ID when contacting AWS Support
    /// for assistance.
    request_id: ?[]const u8 = null,

    /// Is true if the request succeeds and an error otherwise.
    success: ?bool = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .success = "Success",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendSSHPublicKeyInput, options: CallOptions) !SendSSHPublicKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2-instance-connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendSSHPublicKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2-instance-connect", "EC2 Instance Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEC2InstanceConnectService.SendSSHPublicKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendSSHPublicKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendSSHPublicKeyOutput, body, allocator);
}
