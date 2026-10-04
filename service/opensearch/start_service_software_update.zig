const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleAt = @import("schedule_at.zig").ScheduleAt;
const ServiceSoftwareOptions = @import("service_software_options.zig").ServiceSoftwareOptions;

pub const StartServiceSoftwareUpdateInput = struct {
    /// The Epoch timestamp when you want the service software update to start. You
    /// only need
    /// to specify this parameter if you set `ScheduleAt` to
    /// `TIMESTAMP`.
    desired_start_time: ?i64 = null,

    /// The name of the domain that you want to update to the latest service
    /// software.
    domain_name: []const u8,

    /// When to start the service software update.
    ///
    /// * `NOW` - Immediately schedules the update to happen in the current
    /// hour if there's capacity available.
    ///
    /// * `TIMESTAMP` - Lets you specify a custom date and time to apply the
    /// update. If you specify this value, you must also provide a value for
    /// `DesiredStartTime`.
    ///
    /// * `OFF_PEAK_WINDOW` - Marks the update to be picked up during an
    /// upcoming off-peak window. There's no guarantee that the update will happen
    /// during the next immediate window. Depending on capacity, it might happen in
    /// subsequent days.
    ///
    /// Default: `NOW` if you don't specify a value for
    /// `DesiredStartTime`, and `TIMESTAMP` if you do.
    schedule_at: ?ScheduleAt = null,

    pub const json_field_names = .{
        .desired_start_time = "DesiredStartTime",
        .domain_name = "DomainName",
        .schedule_at = "ScheduleAt",
    };
};

pub const StartServiceSoftwareUpdateOutput = struct {
    /// The current status of the OpenSearch Service software update.
    service_software_options: ?ServiceSoftwareOptions = null,

    pub const json_field_names = .{
        .service_software_options = "ServiceSoftwareOptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartServiceSoftwareUpdateInput, options: CallOptions) !StartServiceSoftwareUpdateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartServiceSoftwareUpdateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/serviceSoftwareUpdate/start";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.desired_start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DesiredStartTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DomainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (input.schedule_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScheduleAt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartServiceSoftwareUpdateOutput {
    const result: StartServiceSoftwareUpdateOutput = try aws.json.parseJsonObject(
        StartServiceSoftwareUpdateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
