const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryDestinationConfiguration = @import("delivery_destination_configuration.zig").DeliveryDestinationConfiguration;
const DeliveryDestinationType = @import("delivery_destination_type.zig").DeliveryDestinationType;
const OutputFormat = @import("output_format.zig").OutputFormat;
const DeliveryDestination = @import("delivery_destination.zig").DeliveryDestination;

pub const PutDeliveryDestinationInput = struct {
    /// A structure that contains the ARN of the Amazon Web Services resource that
    /// will receive the
    /// logs.
    ///
    /// `deliveryDestinationConfiguration` is required for CloudWatch Logs,
    /// Amazon S3, Firehose log delivery destinations and not required for
    /// X-Ray trace delivery destinations. `deliveryDestinationType` is
    /// needed for X-Ray trace delivery destinations but not required for other logs
    /// delivery destinations.
    delivery_destination_configuration: ?DeliveryDestinationConfiguration = null,

    /// The type of delivery destination. This parameter specifies the target
    /// service where log
    /// data will be delivered. Valid values include:
    ///
    /// * `S3` - Amazon S3 for long-term storage and analytics
    ///
    /// * `CWL` - CloudWatch Logs for centralized log management
    ///
    /// * `FH` - Amazon Kinesis Data Firehose for real-time data streaming
    ///
    /// * `XRAY` - Amazon Web Services
    /// X-Ray for distributed tracing and application monitoring
    ///
    /// The delivery destination type determines the format and configuration
    /// options available
    /// for log delivery.
    delivery_destination_type: ?DeliveryDestinationType = null,

    /// A name for this delivery destination. This name must be unique for all
    /// delivery
    /// destinations in your account.
    name: []const u8,

    /// The format for the logs that this delivery destination will receive.
    output_format: ?OutputFormat = null,

    /// The ARN of an IAM role in your account that CloudWatch Logs assumes to
    /// deliver to this delivery destination. The trust policy of the role must
    /// allow CloudWatch Logs to assume it. This parameter is supported only for
    /// X-Ray trace delivery
    /// destinations.
    role_arn: ?[]const u8 = null,

    /// An optional list of key-value pairs to associate with the resource.
    ///
    /// For more information about tagging, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .delivery_destination_configuration = "deliveryDestinationConfiguration",
        .delivery_destination_type = "deliveryDestinationType",
        .name = "name",
        .output_format = "outputFormat",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const PutDeliveryDestinationOutput = struct {
    /// A structure containing information about the delivery destination that you
    /// just created or
    /// updated.
    delivery_destination: ?DeliveryDestination = null,

    pub const json_field_names = .{
        .delivery_destination = "deliveryDestination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDeliveryDestinationInput, options: CallOptions) !PutDeliveryDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDeliveryDestinationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutDeliveryDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDeliveryDestinationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutDeliveryDestinationOutput, body, allocator);
}
