const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationSetAttribute = @import("configuration_set_attribute.zig").ConfigurationSetAttribute;
const ConfigurationSet = @import("configuration_set.zig").ConfigurationSet;
const DeliveryOptions = @import("delivery_options.zig").DeliveryOptions;
const EventDestination = @import("event_destination.zig").EventDestination;
const ReputationOptions = @import("reputation_options.zig").ReputationOptions;
const TrackingOptions = @import("tracking_options.zig").TrackingOptions;
const serde = @import("serde.zig");

pub const DescribeConfigurationSetInput = struct {
    /// A list of configuration set attributes to return.
    configuration_set_attribute_names: ?[]const ConfigurationSetAttribute = null,

    /// The name of the configuration set to describe.
    configuration_set_name: []const u8,
};

pub const DescribeConfigurationSetOutput = struct {
    /// The configuration set object associated with the specified configuration
    /// set.
    configuration_set: ?ConfigurationSet = null,

    delivery_options: ?DeliveryOptions = null,

    /// A list of event destinations associated with the configuration set.
    event_destinations: ?[]const EventDestination = null,

    /// An object that represents the reputation settings for the configuration set.
    reputation_options: ?ReputationOptions = null,

    /// The name of the custom open and click tracking domain associated with the
    /// configuration set.
    tracking_options: ?TrackingOptions = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigurationSetInput, options: CallOptions) !DescribeConfigurationSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigurationSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeConfigurationSet&Version=2010-12-01");
    if (input.configuration_set_attribute_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ConfigurationSetAttributeNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    try body_buf.appendSlice(allocator, "&ConfigurationSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.configuration_set_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigurationSetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeConfigurationSetResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeConfigurationSetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConfigurationSet")) {
                    result.configuration_set = try serde.deserializeConfigurationSet(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "DeliveryOptions")) {
                    result.delivery_options = try serde.deserializeDeliveryOptions(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "EventDestinations")) {
                    result.event_destinations = try serde.deserializeEventDestinations(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ReputationOptions")) {
                    result.reputation_options = try serde.deserializeReputationOptions(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "TrackingOptions")) {
                    result.tracking_options = try serde.deserializeTrackingOptions(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
