const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteDeliveryStreamInput = struct {
    /// Set this to true if you want to delete the Firehose stream even if Firehose
    /// is unable to retire the grant for the CMK. Firehose might be unable to
    /// retire
    /// the grant due to a customer error, such as when the CMK or the grant are in
    /// an invalid
    /// state. If you force deletion, you can then use the
    /// [RevokeGrant](https://docs.aws.amazon.com/kms/latest/APIReference/API_RevokeGrant.html) operation to
    /// revoke the grant you gave to Firehose. If a failure to retire the grant
    /// happens due to an Amazon Web Services KMS issue, Firehose keeps retrying the
    /// delete operation.
    ///
    /// The default value is false.
    allow_force_delete: ?bool = null,

    /// The name of the Firehose stream.
    delivery_stream_name: []const u8,

    pub const json_field_names = .{
        .allow_force_delete = "AllowForceDelete",
        .delivery_stream_name = "DeliveryStreamName",
    };
};

pub const DeleteDeliveryStreamOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDeliveryStreamInput, options: CallOptions) !DeleteDeliveryStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "firehose", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDeliveryStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("firehose", "Firehose", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Firehose_20150804.DeleteDeliveryStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDeliveryStreamOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
