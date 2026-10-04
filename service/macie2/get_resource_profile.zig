const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatistics = @import("resource_statistics.zig").ResourceStatistics;

pub const GetResourceProfileInput = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket that the request applies to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};

pub const GetResourceProfileOutput = struct {
    /// The date and time, in UTC and extended ISO 8601 format, when Amazon Macie
    /// most recently recalculated sensitive data discovery statistics and details
    /// for the bucket. If the bucket's sensitivity score is calculated
    /// automatically, this includes the score.
    profile_updated_at: ?i64 = null,

    /// The current sensitivity score for the bucket, ranging from -1
    /// (classification error) to 100 (sensitive). By default, this score is
    /// calculated automatically based on the amount of data that Amazon Macie has
    /// analyzed in the bucket and the amount of sensitive data that Macie has found
    /// in the bucket.
    sensitivity_score: ?i32 = null,

    /// Specifies whether the bucket's current sensitivity score was set manually.
    /// If this value is true, the score was manually changed to 100. If this value
    /// is false, the score was calculated automatically by Amazon Macie.
    sensitivity_score_overridden: ?bool = null,

    /// The sensitive data discovery statistics for the bucket. The statistics
    /// capture the results of automated sensitive data discovery activities that
    /// Amazon Macie has performed for the bucket.
    statistics: ?ResourceStatistics = null,

    pub const json_field_names = .{
        .profile_updated_at = "profileUpdatedAt",
        .sensitivity_score = "sensitivityScore",
        .sensitivity_score_overridden = "sensitivityScoreOverridden",
        .statistics = "statistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceProfileInput, options: CallOptions) !GetResourceProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resource-profiles";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceProfileOutput {
    var result: GetResourceProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
