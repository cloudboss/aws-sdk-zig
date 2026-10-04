const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateScheduleInput = struct {
    /// The date or dates and time or times when the jobs are to be run. For more
    /// information,
    /// see [Cron
    /// expressions](https://docs.aws.amazon.com/databrew/latest/dg/jobs.cron.html)
    /// in the *Glue DataBrew Developer
    /// Guide*.
    cron_expression: []const u8,

    /// The name or names of one or more jobs to be run.
    job_names: ?[]const []const u8 = null,

    /// A unique name for the schedule. Valid characters are alphanumeric (A-Z, a-z,
    /// 0-9),
    /// hyphen (-), period (.), and space.
    name: []const u8,

    /// Metadata tags to apply to this schedule.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cron_expression = "CronExpression",
        .job_names = "JobNames",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateScheduleOutput = struct {
    /// The name of the schedule that was created.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScheduleInput, options: CallOptions) !CreateScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "databrew", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/schedules";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CronExpression\":");
    try aws.json.writeValue(@TypeOf(input.cron_expression), input.cron_expression, allocator, &body_buf);
    has_prev = true;
    if (input.job_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JobNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScheduleOutput {
    const result: CreateScheduleOutput = try aws.json.parseJsonObject(
        CreateScheduleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
