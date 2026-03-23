const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;
const MalwareScanner = @import("malware_scanner.zig").MalwareScanner;
const ScanResultStatus = @import("scan_result_status.zig").ScanResultStatus;
const ScanJobStatus = @import("scan_job_status.zig").ScanJobStatus;
const ScanJobSummary = @import("scan_job_summary.zig").ScanJobSummary;

pub const ListScanJobSummariesInput = struct {
    /// Returns the job count for the specified account.
    ///
    /// If the request is sent from a member account or an account not part of
    /// Amazon Web Services Organizations, jobs within requestor's account will be
    /// returned.
    ///
    /// Root, admin, and delegated administrator accounts can use the value `ANY` to
    /// return job counts from every account in the organization.
    ///
    /// `AGGREGATE_ALL` aggregates job counts from all accounts within the
    /// authenticated organization, then returns the sum.
    account_id: ?[]const u8 = null,

    /// The period for the returned results.
    ///
    /// * `ONE_DAY`The daily job count for the prior 1 day.
    ///
    /// * `SEVEN_DAYS`The daily job count for the prior 7 days.
    ///
    /// * `FOURTEEN_DAYS`The daily job count for the prior 14 days.
    aggregation_period: ?AggregationPeriod = null,

    /// Returns only the scan jobs for the specified malware scanner.
    /// Currently the only MalwareScanner is `GUARDDUTY`. But the field also
    /// supports `ANY`, and `AGGREGATE_ALL`.
    malware_scanner: ?MalwareScanner = null,

    /// The maximum number of items to be returned.
    ///
    /// The value is an integer. Range of accepted values is from 1 to 500.
    max_results: ?i32 = null,

    /// The next item following a partial list of returned items. For example, if a
    /// request is made to
    /// return `MaxResults` number of items, `NextToken` allows you to return more
    /// items
    /// in your list starting at the location pointed to by the next token.
    next_token: ?[]const u8 = null,

    /// Returns the job count for the specified resource type. Use request
    /// `GetSupportedResourceTypes` to obtain strings for supported resource types.
    ///
    /// The the value `ANY` returns count of all resource types.
    ///
    /// `AGGREGATE_ALL` aggregates job counts for all resource types and returns the
    /// sum.
    resource_type: ?[]const u8 = null,

    /// Returns only the scan jobs for the specified scan results.
    scan_result_status: ?ScanResultStatus = null,

    /// Returns only the scan jobs for the specified scanning job state.
    state: ?ScanJobStatus = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aggregation_period = "AggregationPeriod",
        .malware_scanner = "MalwareScanner",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_type = "ResourceType",
        .scan_result_status = "ScanResultStatus",
        .state = "State",
    };
};

pub const ListScanJobSummariesOutput = struct {
    /// The period for the returned results.
    ///
    /// * `ONE_DAY`The daily job count for the prior 1 day.
    ///
    /// * `SEVEN_DAYS`The daily job count for the prior 7 days.
    ///
    /// * `FOURTEEN_DAYS`The daily job count for the prior 14 days.
    ///
    /// Valid Values: `'ONE_DAY'` | `'SEVEN_DAYS'` | `'FOURTEEN_DAYS'`
    aggregation_period: ?[]const u8 = null,

    /// The next item following a partial list of returned items. For example, if a
    /// request is made to
    /// return `MaxResults` number of items, `NextToken` allows you to return more
    /// items
    /// in your list starting at the location pointed to by the next token.
    next_token: ?[]const u8 = null,

    /// The summary information.
    scan_job_summaries: ?[]const ScanJobSummary = null,

    pub const json_field_names = .{
        .aggregation_period = "AggregationPeriod",
        .next_token = "NextToken",
        .scan_job_summaries = "ScanJobSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListScanJobSummariesInput, options: CallOptions) !ListScanJobSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backup");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListScanJobSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/audit/scan-job-summaries";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "AccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.aggregation_period) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "AggregationPeriod=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.malware_scanner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MalwareScanner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ResourceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.scan_result_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ScanResultStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "State=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListScanJobSummariesOutput {
    var result: ListScanJobSummariesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListScanJobSummariesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyFailureException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
