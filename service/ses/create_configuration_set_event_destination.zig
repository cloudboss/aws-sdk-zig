const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventDestination = @import("event_destination.zig").EventDestination;
const serde = @import("serde.zig");

pub const CreateConfigurationSetEventDestinationInput = struct {
    /// The name of the configuration set that the event destination should be
    /// associated
    /// with.
    configuration_set_name: []const u8,

    /// An object that describes the Amazon Web Services service that email sending
    /// event where information
    /// is published.
    event_destination: EventDestination,
};

pub const CreateConfigurationSetEventDestinationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationSetEventDestinationInput, options: CallOptions) !CreateConfigurationSetEventDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationSetEventDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateConfigurationSetEventDestination&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ConfigurationSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.configuration_set_name);
    if (input.event_destination.cloud_watch_destination) |sv| {
        for (sv.dimension_configurations, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EventDestination.CloudWatchDestination.DimensionConfigurations.member.{d}.DefaultDimensionValue=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.default_dimension_value);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EventDestination.CloudWatchDestination.DimensionConfigurations.member.{d}.DimensionName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.dimension_name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EventDestination.CloudWatchDestination.DimensionConfigurations.member.{d}.DimensionValueSource=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.dimension_value_source.wireName());
            }
        }
    }
    if (input.event_destination.enabled) |sv| {
        try body_buf.appendSlice(allocator, "&EventDestination.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.event_destination.kinesis_firehose_destination) |sv| {
        try body_buf.appendSlice(allocator, "&EventDestination.KinesisFirehoseDestination.DeliveryStreamARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.delivery_stream_arn);
        try body_buf.appendSlice(allocator, "&EventDestination.KinesisFirehoseDestination.IAMRoleARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.iam_role_arn);
    }
    for (input.event_destination.matching_event_types, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EventDestination.MatchingEventTypes.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
    }
    try body_buf.appendSlice(allocator, "&EventDestination.Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.event_destination.name);
    if (input.event_destination.sns_destination) |sv| {
        try body_buf.appendSlice(allocator, "&EventDestination.SNSDestination.TopicARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.topic_arn);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationSetEventDestinationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateConfigurationSetEventDestinationOutput = .{};

    return result;
}
