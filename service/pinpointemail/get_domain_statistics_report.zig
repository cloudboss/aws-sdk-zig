const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DailyVolume = @import("daily_volume.zig").DailyVolume;
const OverallVolume = @import("overall_volume.zig").OverallVolume;

pub const GetDomainStatisticsReportInput = struct {
    /// The domain that you want to obtain deliverability metrics for.
    domain: []const u8,

    /// The last day (in Unix time) that you want to obtain domain deliverability
    /// metrics for.
    /// The `EndDate` that you specify has to be less than or equal to 30 days after
    /// the `StartDate`.
    end_date: i64,

    /// The first day (in Unix time) that you want to obtain domain deliverability
    /// metrics
    /// for.
    start_date: i64,

    pub const json_field_names = .{
        .domain = "Domain",
        .end_date = "EndDate",
        .start_date = "StartDate",
    };
};

pub const GetDomainStatisticsReportOutput = struct {
    /// An object that contains deliverability metrics for the domain that you
    /// specified. This
    /// object contains data for each day, starting on the `StartDate` and ending on
    /// the `EndDate`.
    daily_volumes: ?[]const DailyVolume = null,

    /// An object that contains deliverability metrics for the domain that you
    /// specified. The
    /// data in this object is a summary of all of the data that was collected from
    /// the
    /// `StartDate` to the `EndDate`.
    overall_volume: ?OverallVolume = null,

    pub const json_field_names = .{
        .daily_volumes = "DailyVolumes",
        .overall_volume = "OverallVolume",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainStatisticsReportInput, options: CallOptions) !GetDomainStatisticsReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainStatisticsReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/email/deliverability-dashboard/statistics-report/");
    try path_buf.appendSlice(allocator, input.domain);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "EndDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "StartDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainStatisticsReportOutput {
    var result: GetDomainStatisticsReportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDomainStatisticsReportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
