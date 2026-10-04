const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DayOfWeek = @import("day_of_week.zig").DayOfWeek;
const AuditFrequency = @import("audit_frequency.zig").AuditFrequency;
const Tag = @import("tag.zig").Tag;

pub const CreateScheduledAuditInput = struct {
    /// The day of the month on which the scheduled audit takes place.
    /// This
    /// can be "1" through "31" or "LAST". This field is required if the "frequency"
    /// parameter is set to `MONTHLY`. If days
    /// 29
    /// to 31 are specified, and the month
    /// doesn't
    /// have that many days, the audit takes place on the `LAST` day of the month.
    day_of_month: ?[]const u8 = null,

    /// The day of the week on which the scheduled audit takes
    /// place,
    /// either
    /// `SUN`,
    /// `MON`, `TUE`, `WED`, `THU`, `FRI`, or `SAT`. This field is required if the
    /// `frequency`
    /// parameter is set to `WEEKLY` or `BIWEEKLY`.
    day_of_week: ?DayOfWeek = null,

    /// How often the scheduled audit takes
    /// place, either
    /// `DAILY`,
    /// `WEEKLY`, `BIWEEKLY` or `MONTHLY`. The start time of each audit is
    /// determined by the system.
    frequency: AuditFrequency,

    /// The name you want to give to the scheduled audit. (Max. 128 chars)
    scheduled_audit_name: []const u8,

    /// Metadata that can be used to manage the scheduled audit.
    tags: ?[]const Tag = null,

    /// Which checks are performed during the scheduled audit. Checks must be
    /// enabled
    /// for your account. (Use `DescribeAccountAuditConfiguration` to see the list
    /// of all checks, including those that are enabled or use
    /// `UpdateAccountAuditConfiguration`
    /// to select which checks are enabled.)
    target_check_names: []const []const u8,

    pub const json_field_names = .{
        .day_of_month = "dayOfMonth",
        .day_of_week = "dayOfWeek",
        .frequency = "frequency",
        .scheduled_audit_name = "scheduledAuditName",
        .tags = "tags",
        .target_check_names = "targetCheckNames",
    };
};

pub const CreateScheduledAuditOutput = struct {
    /// The ARN of the scheduled audit.
    scheduled_audit_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .scheduled_audit_arn = "scheduledAuditArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScheduledAuditInput, options: CallOptions) !CreateScheduledAuditOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScheduledAuditInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audit/scheduledaudits/");
    try path_buf.appendSlice(allocator, input.scheduled_audit_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.day_of_month) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dayOfMonth\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.day_of_week) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dayOfWeek\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"frequency\":");
    try aws.json.writeValue(@TypeOf(input.frequency), input.frequency, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetCheckNames\":");
    try aws.json.writeValue(@TypeOf(input.target_check_names), input.target_check_names, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScheduledAuditOutput {
    const result: CreateScheduledAuditOutput = try aws.json.parseJsonObject(
        CreateScheduledAuditOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
