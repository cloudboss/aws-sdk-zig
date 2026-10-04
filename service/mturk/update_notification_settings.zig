const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationSpecification = @import("notification_specification.zig").NotificationSpecification;

pub const UpdateNotificationSettingsInput = struct {
    /// Specifies whether notifications are sent for HITs of this HIT type,
    /// according to the notification specification.
    /// You must specify either the Notification parameter or the Active parameter
    /// for the call to UpdateNotificationSettings to succeed.
    active: ?bool = null,

    /// The ID of the HIT type whose notification specification is being updated.
    hit_type_id: []const u8,

    /// The notification specification for the HIT type.
    notification: ?NotificationSpecification = null,

    pub const json_field_names = .{
        .active = "Active",
        .hit_type_id = "HITTypeId",
        .notification = "Notification",
    };
};

pub const UpdateNotificationSettingsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotificationSettingsInput, options: CallOptions) !UpdateNotificationSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNotificationSettingsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.UpdateNotificationSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNotificationSettingsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
