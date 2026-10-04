const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChapInfo = @import("chap_info.zig").ChapInfo;

pub const DescribeChapCredentialsInput = struct {
    /// The Amazon Resource Name (ARN) of the iSCSI volume target. Use the
    /// DescribeStorediSCSIVolumes operation to return to retrieve the TargetARN for
    /// specified VolumeARN.
    target_arn: []const u8,

    pub const json_field_names = .{
        .target_arn = "TargetARN",
    };
};

pub const DescribeChapCredentialsOutput = struct {
    /// An array of ChapInfo objects that represent CHAP credentials. Each
    /// object in the array contains CHAP credential information for one
    /// target-initiator pair. If
    /// no CHAP credentials are set, an empty array is returned. CHAP credential
    /// information is
    /// provided in a JSON object with the following fields:
    ///
    /// * **InitiatorName**: The iSCSI initiator that connects to
    /// the target.
    ///
    /// * **SecretToAuthenticateInitiator**: The secret key that
    /// the initiator (for example, the Windows client) must provide to participate
    /// in mutual
    /// CHAP with the target.
    ///
    /// * **SecretToAuthenticateTarget**: The secret key that the
    /// target must provide to participate in mutual CHAP with the initiator (e.g.
    /// Windows
    /// client).
    ///
    /// * **TargetARN**: The Amazon Resource Name (ARN) of the
    /// storage volume.
    chap_credentials: ?[]const ChapInfo = null,

    pub const json_field_names = .{
        .chap_credentials = "ChapCredentials",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChapCredentialsInput, options: CallOptions) !DescribeChapCredentialsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChapCredentialsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeChapCredentials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChapCredentialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeChapCredentialsOutput, body, allocator);
}
