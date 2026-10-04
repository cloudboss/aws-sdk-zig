const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RetrieveTapeArchiveInput = struct {
    /// The Amazon Resource Name (ARN) of the gateway you want to retrieve the
    /// virtual tape to.
    /// Use the ListGateways operation to return a list of gateways for your
    /// account and Amazon Web Services Region.
    ///
    /// You retrieve archived virtual tapes to only one gateway and the gateway must
    /// be a tape
    /// gateway.
    gateway_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the virtual tape you want to retrieve from
    /// the virtual
    /// tape shelf (VTS).
    tape_arn: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .tape_arn = "TapeARN",
    };
};

pub const RetrieveTapeArchiveOutput = struct {
    /// The Amazon Resource Name (ARN) of the retrieved virtual tape.
    tape_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .tape_arn = "TapeARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveTapeArchiveInput, options: CallOptions) !RetrieveTapeArchiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveTapeArchiveInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.RetrieveTapeArchive");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveTapeArchiveOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RetrieveTapeArchiveOutput, body, allocator);
}
