const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingsStatistics = @import("findings_statistics.zig").FindingsStatistics;

pub const GetFindingsStatisticsInput = struct {
    /// The [ARN of the
    /// analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#permission-resources) used to generate the statistics.
    analyzer_arn: []const u8,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
    };
};

pub const GetFindingsStatisticsOutput = struct {
    /// A group of external access or unused access findings statistics.
    findings_statistics: ?[]const FindingsStatistics = null,

    /// The time at which the retrieval of the findings statistics was last updated.
    /// If the findings statistics have not been previously retrieved for the
    /// specified analyzer, this field will not be populated.
    last_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .findings_statistics = "findingsStatistics",
        .last_updated_at = "lastUpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingsStatisticsInput, options: CallOptions) !GetFindingsStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingsStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/analyzer/findings/statistics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analyzerArn\":");
    try aws.json.writeValue(@TypeOf(input.analyzer_arn), input.analyzer_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingsStatisticsOutput {
    const result: GetFindingsStatisticsOutput = try aws.json.parseJsonObject(
        GetFindingsStatisticsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
