const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeScheduleInput = struct {
    /// The name of the schedule to be described.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeScheduleOutput = struct {
    /// The date and time that the schedule was created.
    create_date: ?i64 = null,

    /// The identifier (user name) of the user who created the schedule.
    created_by: ?[]const u8 = null,

    /// The date or dates and time or times when the jobs are to be run for the
    /// schedule. For
    /// more information, see [Cron
    /// expressions](https://docs.aws.amazon.com/databrew/latest/dg/jobs.cron.html)
    /// in the
    /// *Glue DataBrew Developer Guide*.
    cron_expression: ?[]const u8 = null,

    /// The name or names of one or more jobs to be run by using the schedule.
    job_names: ?[]const []const u8 = null,

    /// The identifier (user name) of the user who last modified the schedule.
    last_modified_by: ?[]const u8 = null,

    /// The date and time that the schedule was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the schedule.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the schedule.
    resource_arn: ?[]const u8 = null,

    /// Metadata tags associated with this schedule.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .cron_expression = "CronExpression",
        .job_names = "JobNames",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeScheduleInput, options: CallOptions) !DescribeScheduleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/schedules/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeScheduleOutput {
    var result: DescribeScheduleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeScheduleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
