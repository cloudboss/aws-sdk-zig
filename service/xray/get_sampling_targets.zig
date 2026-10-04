const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SamplingBoostStatisticsDocument = @import("sampling_boost_statistics_document.zig").SamplingBoostStatisticsDocument;
const SamplingStatisticsDocument = @import("sampling_statistics_document.zig").SamplingStatisticsDocument;
const SamplingTargetDocument = @import("sampling_target_document.zig").SamplingTargetDocument;
const UnprocessedStatistics = @import("unprocessed_statistics.zig").UnprocessedStatistics;

pub const GetSamplingTargetsInput = struct {
    /// Information about rules that the service is using to boost sampling rate.
    sampling_boost_statistics_documents: ?[]const SamplingBoostStatisticsDocument = null,

    /// Information about rules that the service is using to sample requests.
    sampling_statistics_documents: []const SamplingStatisticsDocument,

    pub const json_field_names = .{
        .sampling_boost_statistics_documents = "SamplingBoostStatisticsDocuments",
        .sampling_statistics_documents = "SamplingStatisticsDocuments",
    };
};

pub const GetSamplingTargetsOutput = struct {
    /// The last time a user changed the sampling rule configuration. If
    /// the sampling rule configuration changed since the service last retrieved it,
    /// the service
    /// should call
    /// [GetSamplingRules](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingRules.html) to get the latest version.
    last_rule_modification: ?i64 = null,

    /// Updated rules that the service should use to sample requests.
    sampling_target_documents: ?[]const SamplingTargetDocument = null,

    /// Information about
    /// [SamplingBoostStatisticsDocument](https://docs.aws.amazon.com/xray/latest/api/API_SamplingBoostStatisticsDocument.html) that X-Ray could not
    /// process.
    unprocessed_boost_statistics: ?[]const UnprocessedStatistics = null,

    /// Information about
    /// [SamplingStatisticsDocument](https://docs.aws.amazon.com/xray/latest/api/API_SamplingStatisticsDocument.html) that X-Ray could not
    /// process.
    unprocessed_statistics: ?[]const UnprocessedStatistics = null,

    pub const json_field_names = .{
        .last_rule_modification = "LastRuleModification",
        .sampling_target_documents = "SamplingTargetDocuments",
        .unprocessed_boost_statistics = "UnprocessedBoostStatistics",
        .unprocessed_statistics = "UnprocessedStatistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSamplingTargetsInput, options: CallOptions) !GetSamplingTargetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSamplingTargetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/SamplingTargets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.sampling_boost_statistics_documents) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SamplingBoostStatisticsDocuments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SamplingStatisticsDocuments\":");
    try aws.json.writeValue(@TypeOf(input.sampling_statistics_documents), input.sampling_statistics_documents, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSamplingTargetsOutput {
    const result: GetSamplingTargetsOutput = try aws.json.parseJsonObject(
        GetSamplingTargetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
