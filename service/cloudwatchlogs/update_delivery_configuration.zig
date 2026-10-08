const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3DeliveryConfiguration = @import("s3_delivery_configuration.zig").S3DeliveryConfiguration;

pub const UpdateDeliveryConfigurationInput = struct {
    /// The field delimiter to use between record fields when the final output
    /// format of a
    /// delivery is in `Plain`, `W3C`, or `Raw` format.
    field_delimiter: ?[]const u8 = null,

    /// The ID of the delivery to be updated by this request.
    id: []const u8,

    /// The list of record fields to be delivered to the destination, in order. If
    /// the delivery's
    /// log source has mandatory fields, they must be included in this list.
    record_fields: ?[]const []const u8 = null,

    /// This structure contains parameters that are valid only when the delivery's
    /// delivery
    /// destination is an S3 bucket.
    s_3_delivery_configuration: ?S3DeliveryConfiguration = null,

    pub const json_field_names = .{
        .field_delimiter = "fieldDelimiter",
        .id = "id",
        .record_fields = "recordFields",
        .s_3_delivery_configuration = "s3DeliveryConfiguration",
    };
};

pub const UpdateDeliveryConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDeliveryConfigurationInput, options: CallOptions) !UpdateDeliveryConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDeliveryConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.UpdateDeliveryConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDeliveryConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
