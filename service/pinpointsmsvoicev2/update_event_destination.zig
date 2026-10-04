const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudWatchLogsDestination = @import("cloud_watch_logs_destination.zig").CloudWatchLogsDestination;
const KinesisFirehoseDestination = @import("kinesis_firehose_destination.zig").KinesisFirehoseDestination;
const EventType = @import("event_type.zig").EventType;
const SnsDestination = @import("sns_destination.zig").SnsDestination;
const EventDestination = @import("event_destination.zig").EventDestination;

pub const UpdateEventDestinationInput = struct {
    /// An object that contains information about an event destination that sends
    /// data to CloudWatch Logs.
    cloud_watch_logs_destination: ?CloudWatchLogsDestination = null,

    /// The configuration set to update with the new event destination. Valid values
    /// for this can be the ConfigurationSetName or ConfigurationSetArn.
    configuration_set_name: []const u8,

    /// When set to true logging is enabled.
    enabled: ?bool = null,

    /// The name to use for the event destination.
    event_destination_name: []const u8,

    /// An object that contains information about an event destination for logging
    /// to Firehose.
    kinesis_firehose_destination: ?KinesisFirehoseDestination = null,

    /// An array of event types that determine which events to log.
    ///
    /// The `TEXT_SENT` event type is not supported.
    matching_event_types: ?[]const EventType = null,

    /// An object that contains information about an event destination that sends
    /// data to Amazon SNS.
    sns_destination: ?SnsDestination = null,

    pub const json_field_names = .{
        .cloud_watch_logs_destination = "CloudWatchLogsDestination",
        .configuration_set_name = "ConfigurationSetName",
        .enabled = "Enabled",
        .event_destination_name = "EventDestinationName",
        .kinesis_firehose_destination = "KinesisFirehoseDestination",
        .matching_event_types = "MatchingEventTypes",
        .sns_destination = "SnsDestination",
    };
};

pub const UpdateEventDestinationOutput = struct {
    /// The Amazon Resource Name (ARN) for the ConfigurationSet that was updated.
    configuration_set_arn: ?[]const u8 = null,

    /// The name of the configuration set.
    configuration_set_name: ?[]const u8 = null,

    /// An EventDestination object containing the details of where events will be
    /// logged.
    event_destination: ?EventDestination = null,

    pub const json_field_names = .{
        .configuration_set_arn = "ConfigurationSetArn",
        .configuration_set_name = "ConfigurationSetName",
        .event_destination = "EventDestination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventDestinationInput, options: CallOptions) !UpdateEventDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.UpdateEventDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEventDestinationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEventDestinationOutput, body, allocator);
}
