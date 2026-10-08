const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchFilter = @import("search_filter.zig").SearchFilter;
const DataSourceSport = @import("data_source_sport.zig").DataSourceSport;
const FixtureSummary = @import("fixture_summary.zig").FixtureSummary;

pub const SearchFixturesInput = struct {
    /// The last day of the search window, in UTC. The search includes fixtures that
    /// are scheduled on this day. Specify the date in ISO 8601 format, as
    /// `YYYY-MM-DD`.
    ///
    /// If you omit this parameter, Elemental Inference searches only the day that
    /// you specified in startDate. The window from startDate through endDate must
    /// not exceed seven days.
    end_date: ?[]const u8 = null,

    /// An array of filters that narrow the results. Each filter applies to one
    /// dimension of a fixture, such as the competitor. You can specify up to 10
    /// filters.
    ///
    /// A fixture must satisfy every filter in the array in order to appear in the
    /// results. Within one filter, a fixture must match at least one of the values.
    filters: ?[]const SearchFilter = null,

    /// The maximum number of fixtures to return for each API request.
    ///
    /// The service might return fewer fixtures than the maxResults value. When more
    /// fixtures match the search, the response also includes a nextToken value that
    /// you can use to fetch the next batch of results.
    max_results: ?i32 = null,

    /// The token that identifies the batch of results that you want to see.
    ///
    /// For example, you submit a SearchFixtures request with maxResults set at 5.
    /// The service returns the first batch of results (up to 5) and a nextToken
    /// value. To see the next batch of results, you submit the SearchFixtures
    /// request a second time, with the same search criteria, and specify the
    /// nextToken value.
    next_token: ?[]const u8 = null,

    /// The sport to search for fixtures. Valid values: basketball (search for
    /// basketball fixtures), american-football (search for american-football
    /// fixtures).
    sport: DataSourceSport,

    /// The first day of the search window, in UTC. The search includes fixtures
    /// that are scheduled on this day.
    ///
    /// Specify the date in ISO 8601 format, as `YYYY-MM-DD`. For example,
    /// 2026-03-14.
    start_date: []const u8,

    pub const json_field_names = .{
        .end_date = "endDate",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sport = "sport",
        .start_date = "startDate",
    };
};

pub const SearchFixturesOutput = struct {
    /// An array of FixtureSummary objects, one for each fixture that matches the
    /// search. The array is empty if no fixtures match.
    fixtures: ?[]const FixtureSummary = null,

    /// The token that identifies the next batch of results. To see the next batch,
    /// submit the SearchFixtures request again, with the same search criteria, and
    /// specify this value in nextToken.
    ///
    /// This parameter is absent when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fixtures = "fixtures",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchFixturesInput, options: CallOptions) !SearchFixturesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elemental-inference", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchFixturesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/fixtures";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.end_date) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endDate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sport\":");
    try aws.json.writeValue(@TypeOf(input.sport), input.sport, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startDate\":");
    try aws.json.writeValue(@TypeOf(input.start_date), input.start_date, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchFixturesOutput {
    const result: SearchFixturesOutput = try aws.json.parseJsonObject(
        SearchFixturesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
