const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendSerialConsoleSSHPublicKeyInput = struct {
    /// The ID of the EC2 instance.
    instance_id: []const u8,

    /// The serial port of the EC2 instance. Currently only port 0 is supported.
    ///
    /// Default: 0
    serial_port: ?i32 = null,

    /// The public key material. To use the public key, you must have the matching
    /// private
    /// key. For information about the supported key formats and lengths, see
    /// [Requirements for key
    /// pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws) in the *Amazon EC2 User
    /// Guide*.
    ssh_public_key: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .serial_port = "SerialPort",
        .ssh_public_key = "SSHPublicKey",
    };
};

pub const SendSerialConsoleSSHPublicKeyOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendSerialConsoleSSHPublicKeyInput, options: CallOptions) !SendSerialConsoleSSHPublicKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendSerialConsoleSSHPublicKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEC2InstanceConnectService.SendSerialConsoleSSHPublicKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendSerialConsoleSSHPublicKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendSerialConsoleSSHPublicKeyOutput, body, allocator);
}
