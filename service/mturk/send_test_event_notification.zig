const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationSpecification = @import("notification_specification.zig").NotificationSpecification;
const EventType = @import("event_type.zig").EventType;

pub const SendTestEventNotificationInput = struct {
    /// The notification specification to test. This value is identical to the value
    /// you would provide to the UpdateNotificationSettings operation when you
    /// establish
    /// the notification specification for a HIT type.
    notification: NotificationSpecification,

    /// The event to simulate to test the notification specification.
    /// This event is included in the test message even if the notification
    /// specification
    /// does not include the event type.
    /// The notification specification does not filter out the test event.
    test_event_type: EventType,

    pub const json_field_names = .{
        .notification = "Notification",
        .test_event_type = "TestEventType",
    };
};

pub const SendTestEventNotificationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendTestEventNotificationInput, options: CallOptions) !SendTestEventNotificationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mturk-requester", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendTestEventNotificationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk-requester", "MTurk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.SendTestEventNotification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendTestEventNotificationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
