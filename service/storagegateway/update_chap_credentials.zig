const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateChapCredentialsInput = struct {
    /// The iSCSI initiator that connects to the target.
    initiator_name: []const u8,

    /// The secret key that the initiator (for example, the Windows client) must
    /// provide to
    /// participate in mutual CHAP with the target.
    ///
    /// The secret key must be between 12 and 16 bytes when encoded in UTF-8.
    secret_to_authenticate_initiator: []const u8,

    /// The secret key that the target must provide to participate in mutual CHAP
    /// with the
    /// initiator (e.g. Windows client).
    ///
    /// Byte constraints: Minimum bytes of 12. Maximum bytes of 16.
    ///
    /// The secret key must be between 12 and 16 bytes when encoded in UTF-8.
    secret_to_authenticate_target: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the iSCSI volume target. Use the
    /// DescribeStorediSCSIVolumes operation to return the TargetARN for specified
    /// VolumeARN.
    target_arn: []const u8,

    pub const json_field_names = .{
        .initiator_name = "InitiatorName",
        .secret_to_authenticate_initiator = "SecretToAuthenticateInitiator",
        .secret_to_authenticate_target = "SecretToAuthenticateTarget",
        .target_arn = "TargetARN",
    };
};

pub const UpdateChapCredentialsOutput = struct {
    /// The iSCSI initiator that connects to the target. This is the same initiator
    /// name
    /// specified in the request.
    initiator_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the target. This is the same target
    /// specified in the
    /// request.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .initiator_name = "InitiatorName",
        .target_arn = "TargetARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChapCredentialsInput, options: CallOptions) !UpdateChapCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChapCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.UpdateChapCredentials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChapCredentialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateChapCredentialsOutput, body, allocator);
}
