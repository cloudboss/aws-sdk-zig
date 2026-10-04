const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateCrawlerScheduleInput = struct {
    /// The name of the crawler whose schedule to update.
    crawler_name: []const u8,

    /// The updated `cron` expression used to specify the schedule (see [Time-Based
    /// Schedules for Jobs and
    /// Crawlers](https://docs.aws.amazon.com/glue/latest/dg/monitor-data-warehouse-schedule.html). For example, to run
    /// something every day at 12:15 UTC, you would specify:
    /// `cron(15 12 * * ? *)`.
    schedule: ?[]const u8 = null,

    pub const json_field_names = .{
        .crawler_name = "CrawlerName",
        .schedule = "Schedule",
    };
};

pub const UpdateCrawlerScheduleOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCrawlerScheduleInput, options: CallOptions) !UpdateCrawlerScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCrawlerScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateCrawlerSchedule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCrawlerScheduleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
