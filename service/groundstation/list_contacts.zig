const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EphemerisFilter = @import("ephemeris_filter.zig").EphemerisFilter;
const ContactStatus = @import("contact_status.zig").ContactStatus;
const ContactData = @import("contact_data.zig").ContactData;

pub const ListContactsInput = struct {
    /// End time of a contact in UTC.
    end_time: i64,

    /// Filter for selecting contacts that use a specific ephemeris".
    ephemeris: ?EphemerisFilter = null,

    /// Name of a ground station.
    ground_station: ?[]const u8 = null,

    /// Maximum number of contacts returned.
    max_results: ?i32 = null,

    /// ARN of a mission profile.
    mission_profile_arn: ?[]const u8 = null,

    /// Next token returned in the request of a previous `ListContacts` call. Used
    /// to get the next page of results.
    next_token: ?[]const u8 = null,

    /// ARN of a satellite.
    satellite_arn: ?[]const u8 = null,

    /// Start time of a contact in UTC.
    start_time: i64,

    /// Status of a contact reservation.
    status_list: []const ContactStatus,

    pub const json_field_names = .{
        .end_time = "endTime",
        .ephemeris = "ephemeris",
        .ground_station = "groundStation",
        .max_results = "maxResults",
        .mission_profile_arn = "missionProfileArn",
        .next_token = "nextToken",
        .satellite_arn = "satelliteArn",
        .start_time = "startTime",
        .status_list = "statusList",
    };
};

pub const ListContactsOutput = struct {
    /// List of contacts.
    contact_list: ?[]const ContactData = null,

    /// Next token returned in the response of a previous `ListContacts` call. Used
    /// to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_list = "contactList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListContactsInput, options: CallOptions) !ListContactsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListContactsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contacts";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.ephemeris) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ephemeris\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ground_station) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groundStation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mission_profile_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"missionProfileArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.satellite_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"satelliteArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"statusList\":");
    try aws.json.writeValue(@TypeOf(input.status_list), input.status_list, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListContactsOutput {
    const result: ListContactsOutput = try aws.json.parseJsonObject(
        ListContactsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
