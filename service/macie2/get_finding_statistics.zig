const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingCriteria = @import("finding_criteria.zig").FindingCriteria;
const GroupBy = @import("group_by.zig").GroupBy;
const FindingStatisticsSortCriteria = @import("finding_statistics_sort_criteria.zig").FindingStatisticsSortCriteria;
const GroupCount = @import("group_count.zig").GroupCount;

pub const GetFindingStatisticsInput = struct {
    /// The criteria to use to filter the query results.
    finding_criteria: ?FindingCriteria = null,

    /// The finding property to use to group the query results. Valid values are:
    ///
    /// * classificationDetails.jobId - The unique identifier for the classification
    ///   job that produced the finding.
    /// * resourcesAffected.s3Bucket.name - The name of the S3 bucket that the
    ///   finding applies to.
    /// * severity.description - The severity level of the finding, such as High or
    ///   Medium.
    /// * type - The type of finding, such as Policy:IAMUser/S3BucketPublic and
    ///   SensitiveData:S3Object/Personal.
    group_by: GroupBy,

    /// The maximum number of items to include in each page of the response.
    size: ?i32 = null,

    /// The criteria to use to sort the query results.
    sort_criteria: ?FindingStatisticsSortCriteria = null,

    pub const json_field_names = .{
        .finding_criteria = "findingCriteria",
        .group_by = "groupBy",
        .size = "size",
        .sort_criteria = "sortCriteria",
    };
};

pub const GetFindingStatisticsOutput = struct {
    /// An array of objects, one for each group of findings that matches the filter
    /// criteria specified in the request.
    counts_by_group: ?[]const GroupCount = null,

    pub const json_field_names = .{
        .counts_by_group = "countsByGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingStatisticsInput, options: CallOptions) !GetFindingStatisticsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findings/statistics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.finding_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"findingCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"groupBy\":");
    try aws.json.writeValue(@TypeOf(input.group_by), input.group_by, allocator, &body_buf);
    has_prev = true;
    if (input.size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"size\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingStatisticsOutput {
    var result: GetFindingStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFindingStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
