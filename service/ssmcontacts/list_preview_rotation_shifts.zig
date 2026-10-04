const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PreviewOverride = @import("preview_override.zig").PreviewOverride;
const RecurrenceSettings = @import("recurrence_settings.zig").RecurrenceSettings;
const RotationShift = @import("rotation_shift.zig").RotationShift;

pub const ListPreviewRotationShiftsInput = struct {
    /// The date and time a rotation shift would end.
    end_time: i64,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that
    /// can be specified in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The contacts that would be assigned to a rotation.
    members: []const []const u8,

    /// A token to start the list. This token is used to get the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// Information about changes that would be made in a rotation override.
    overrides: ?[]const PreviewOverride = null,

    /// Information about how long a rotation would last before restarting at the
    /// beginning of
    /// the shift order.
    recurrence: RecurrenceSettings,

    /// The date and time a rotation would begin. The first shift is calculated from
    /// this date
    /// and time.
    rotation_start_time: ?i64 = null,

    /// Used to filter the range of calculated shifts before sending the response
    /// back to the
    /// user.
    start_time: ?i64 = null,

    /// The time zone the rotation’s activity would be based on, in Internet
    /// Assigned Numbers
    /// Authority (IANA) format. For example: "America/Los_Angeles", "UTC", or
    /// "Asia/Seoul".
    time_zone_id: []const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .members = "Members",
        .next_token = "NextToken",
        .overrides = "Overrides",
        .recurrence = "Recurrence",
        .rotation_start_time = "RotationStartTime",
        .start_time = "StartTime",
        .time_zone_id = "TimeZoneId",
    };
};

pub const ListPreviewRotationShiftsOutput = struct {
    /// The token for the next set of items to return. This token is used to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// Details about a rotation shift, including times, types, and contacts.
    rotation_shifts: ?[]const RotationShift = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rotation_shifts = "RotationShifts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPreviewRotationShiftsInput, options: CallOptions) !ListPreviewRotationShiftsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPreviewRotationShiftsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.ListPreviewRotationShifts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPreviewRotationShiftsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPreviewRotationShiftsOutput, body, allocator);
}
