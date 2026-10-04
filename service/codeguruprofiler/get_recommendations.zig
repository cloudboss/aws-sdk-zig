const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Anomaly = @import("anomaly.zig").Anomaly;
const Recommendation = @import("recommendation.zig").Recommendation;

pub const GetRecommendationsInput = struct {
    /// The start time of the profile to get analysis data about. You must specify
    /// `startTime` and `endTime`.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    end_time: i64,

    /// The language used to provide analysis. Specify using a string that is one
    /// of the following `BCP 47` language codes.
    ///
    /// * `de-DE` - German, Germany
    ///
    /// * `en-GB` - English, United Kingdom
    ///
    /// * `en-US` - English, United States
    ///
    /// * `es-ES` - Spanish, Spain
    ///
    /// * `fr-FR` - French, France
    ///
    /// * `it-IT` - Italian, Italy
    ///
    /// * `ja-JP` - Japanese, Japan
    ///
    /// * `ko-KR` - Korean, Republic of Korea
    ///
    /// * `pt-BR` - Portugese, Brazil
    ///
    /// * `zh-CN` - Chinese, China
    ///
    /// * `zh-TW` - Chinese, Taiwan
    locale: ?[]const u8 = null,

    /// The name of the profiling group to get analysis data about.
    profiling_group_name: []const u8,

    /// The end time of the profile to get analysis data about. You must specify
    /// `startTime` and `endTime`.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .locale = "locale",
        .profiling_group_name = "profilingGroupName",
        .start_time = "startTime",
    };
};

pub const GetRecommendationsOutput = struct {
    /// The list of anomalies that the analysis has found for this profile.
    anomalies: ?[]const Anomaly = null,

    /// The end time of the profile the analysis data is about. This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    profile_end_time: i64,

    /// The start time of the profile the analysis data is about. This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    profile_start_time: i64,

    /// The name of the profiling group the analysis data is about.
    profiling_group_name: []const u8,

    /// The list of recommendations that the analysis found for this profile.
    recommendations: ?[]const Recommendation = null,

    pub const json_field_names = .{
        .anomalies = "anomalies",
        .profile_end_time = "profileEndTime",
        .profile_start_time = "profileStartTime",
        .profiling_group_name = "profilingGroupName",
        .recommendations = "recommendations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationsInput, options: CallOptions) !GetRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-profiler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/internal/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/recommendations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.locale) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "locale=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "startTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "";
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendationsOutput {
    const result: GetRecommendationsOutput = try aws.json.parseJsonObject(
        GetRecommendationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
