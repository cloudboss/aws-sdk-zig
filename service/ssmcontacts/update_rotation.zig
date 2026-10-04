const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecurrenceSettings = @import("recurrence_settings.zig").RecurrenceSettings;

pub const UpdateRotationInput = struct {
    /// The Amazon Resource Names (ARNs) of the contacts to include in the updated
    /// rotation.
    ///
    /// Only the `PERSONAL` contact type is supported. The contact types
    /// `ESCALATION` and `ONCALL_SCHEDULE` are not supported for this
    /// operation.
    ///
    /// The order in which you list the contacts is their shift order in the
    /// rotation
    /// schedule.
    contact_ids: ?[]const []const u8 = null,

    /// Information about how long the updated rotation lasts before restarting at
    /// the beginning
    /// of the shift order.
    recurrence: RecurrenceSettings,

    /// The Amazon Resource Name (ARN) of the rotation to update.
    rotation_id: []const u8,

    /// The date and time the rotation goes into effect.
    start_time: ?i64 = null,

    /// The time zone to base the updated rotation’s activity on, in Internet
    /// Assigned Numbers
    /// Authority (IANA) format. For example: "America/Los_Angeles", "UTC", or
    /// "Asia/Seoul". For
    /// more information, see the [Time Zone
    /// Database](https://www.iana.org/time-zones) on the IANA website.
    ///
    /// Designators for time zones that don’t support Daylight Savings Time Rules,
    /// such as
    /// Pacific Standard Time (PST), aren't supported.
    time_zone_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_ids = "ContactIds",
        .recurrence = "Recurrence",
        .rotation_id = "RotationId",
        .start_time = "StartTime",
        .time_zone_id = "TimeZoneId",
    };
};

pub const UpdateRotationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRotationInput, options: CallOptions) !UpdateRotationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRotationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-contacts", "SSM Contacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.UpdateRotation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRotationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
