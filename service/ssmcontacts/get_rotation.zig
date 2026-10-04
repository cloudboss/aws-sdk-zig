const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecurrenceSettings = @import("recurrence_settings.zig").RecurrenceSettings;

pub const GetRotationInput = struct {
    /// The Amazon Resource Name (ARN) of the on-call rotation to retrieve
    /// information
    /// about.
    rotation_id: []const u8,

    pub const json_field_names = .{
        .rotation_id = "RotationId",
    };
};

pub const GetRotationOutput = struct {
    /// The Amazon Resource Names (ARNs) of the contacts assigned to the on-call
    /// rotation
    /// team.
    contact_ids: ?[]const []const u8 = null,

    /// The name of the on-call rotation.
    name: []const u8,

    /// Specifies how long a rotation lasts before restarting at the beginning of
    /// the shift
    /// order.
    recurrence: ?RecurrenceSettings = null,

    /// The Amazon Resource Name (ARN) of the on-call rotation.
    rotation_arn: []const u8,

    /// The specified start time for the on-call rotation.
    start_time: i64,

    /// The time zone that the rotation’s activity is based on, in Internet Assigned
    /// Numbers
    /// Authority (IANA) format.
    time_zone_id: []const u8,

    pub const json_field_names = .{
        .contact_ids = "ContactIds",
        .name = "Name",
        .recurrence = "Recurrence",
        .rotation_arn = "RotationArn",
        .start_time = "StartTime",
        .time_zone_id = "TimeZoneId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRotationInput, options: CallOptions) !GetRotationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRotationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.GetRotation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRotationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRotationOutput, body, allocator);
}
