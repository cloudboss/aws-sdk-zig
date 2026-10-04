const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsSecurityFindingIdentifier = @import("aws_security_finding_identifier.zig").AwsSecurityFindingIdentifier;
const FindingHistoryRecord = @import("finding_history_record.zig").FindingHistoryRecord;

pub const GetFindingHistoryInput = struct {
    /// An ISO 8601-formatted timestamp that indicates the end time of the requested
    /// finding history.
    ///
    /// If you provide values for both `StartTime` and `EndTime`,
    /// Security Hub CSPM returns finding history for the specified time period. If
    /// you
    /// provide a value for `StartTime` but not for `EndTime`, Security Hub CSPM
    /// returns finding history from the `StartTime` to the time at
    /// which the API is called. If you provide a value for `EndTime` but not for
    /// `StartTime`, Security Hub CSPM returns finding history from the
    /// [CreatedAt](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_AwsSecurityFindingFilters.html#securityhub-Type-AwsSecurityFindingFilters-CreatedAt) timestamp of the finding to the `EndTime`. If you
    /// provide neither `StartTime` nor `EndTime`, Security Hub CSPM
    /// returns finding history from the `CreatedAt` timestamp of the finding to the
    /// time at which
    /// the API is called. In all of these scenarios, the response is limited to 100
    /// results.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    end_time: ?i64 = null,

    finding_identifier: AwsSecurityFindingIdentifier,

    /// The maximum number of results to be returned. If you don’t provide it,
    /// Security Hub CSPM returns up to 100 results of finding history.
    max_results: ?i32 = null,

    /// A token for pagination purposes. Provide `NULL` as the initial value. In
    /// subsequent requests, provide the
    /// token included in the response to get up to an additional 100 results of
    /// finding history. If you don’t provide
    /// `NextToken`, Security Hub CSPM returns up to 100 results of finding history
    /// for each request.
    next_token: ?[]const u8 = null,

    /// A timestamp that indicates the start time of the requested finding history.
    ///
    /// If you provide values for both `StartTime` and `EndTime`,
    /// Security Hub CSPM returns finding history for the specified time period. If
    /// you
    /// provide a value for `StartTime` but not for `EndTime`, Security Hub CSPM
    /// returns finding history from the `StartTime` to the time at
    /// which the API is called. If you provide a value for `EndTime` but not for
    /// `StartTime`, Security Hub CSPM returns finding history from the
    /// [CreatedAt](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_AwsSecurityFindingFilters.html#securityhub-Type-AwsSecurityFindingFilters-CreatedAt) timestamp of the finding to the `EndTime`. If you
    /// provide neither `StartTime` nor `EndTime`, Security Hub CSPM
    /// returns finding history from the `CreatedAt` timestamp of the finding to the
    /// time at which
    /// the API is called. In all of these scenarios, the response is limited to 100
    /// results.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .finding_identifier = "FindingIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const GetFindingHistoryOutput = struct {
    /// A token for pagination purposes. Provide this token in the subsequent
    /// request to `GetFindingsHistory` to
    /// get up to an additional 100 results of history for the same finding that you
    /// specified in your initial request.
    next_token: ?[]const u8 = null,

    /// A list of events that altered the specified finding during the specified
    /// time period.
    records: ?[]const FindingHistoryRecord = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .records = "Records",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingHistoryInput, options: CallOptions) !GetFindingHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findingHistory/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.end_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EndTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FindingIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.finding_identifier), input.finding_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartTime\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingHistoryOutput {
    var result: GetFindingHistoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFindingHistoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
