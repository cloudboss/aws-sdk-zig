const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;
const CopyJobStatus = @import("copy_job_status.zig").CopyJobStatus;
const CopyJobSummary = @import("copy_job_summary.zig").CopyJobSummary;

pub const ListCopyJobSummariesInput = struct {
    /// Returns the job count for the specified account.
    ///
    /// If the request is sent from a member account or an account
    /// not part of Amazon Web Services Organizations, jobs within requestor's
    /// account
    /// will be returned.
    ///
    /// Root, admin, and delegated administrator accounts can use
    /// the value ANY to return job counts from every account in the
    /// organization.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// from all accounts within the authenticated organization,
    /// then returns the sum.
    account_id: ?[]const u8 = null,

    /// The period for the returned results.
    ///
    /// * `ONE_DAY` - The daily job count for the prior 14 days.
    ///
    /// * `SEVEN_DAYS` - The aggregated job count for the prior 7 days.
    ///
    /// * `FOURTEEN_DAYS` - The aggregated job count for prior 14 days.
    aggregation_period: ?AggregationPeriod = null,

    /// This parameter sets the maximum number of items
    /// to be returned.
    ///
    /// The value is an integer. Range of accepted values is from
    /// 1 to 500.
    max_results: ?i32 = null,

    /// This parameter returns the job count for the specified
    /// message category.
    ///
    /// Example accepted strings include `AccessDenied`,
    /// `Success`, and `InvalidParameters`. See
    /// [Monitoring](https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html)
    /// for a list of accepted MessageCategory strings.
    ///
    /// The the value ANY returns count of all message categories.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// for all message categories and returns the sum.
    message_category: ?[]const u8 = null,

    /// The next item following a partial list of returned resources. For example,
    /// if a request
    /// is made to return `MaxResults` number of resources, `NextToken`
    /// allows you to return more items in your list starting at the location
    /// pointed to by the
    /// next token.
    next_token: ?[]const u8 = null,

    /// Returns the job count for the specified resource type.
    /// Use request `GetSupportedResourceTypes` to obtain
    /// strings for supported resource types.
    ///
    /// The the value ANY returns count of all resource types.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// for all resource types and returns the sum.
    ///
    /// The type of Amazon Web Services resource to be backed up; for example, an
    /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
    /// Database Service (Amazon RDS) database.
    resource_type: ?[]const u8 = null,

    /// This parameter returns the job count for jobs
    /// with the specified state.
    ///
    /// The the value ANY returns count of all states.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// for all states and returns the sum.
    state: ?CopyJobStatus = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aggregation_period = "AggregationPeriod",
        .max_results = "MaxResults",
        .message_category = "MessageCategory",
        .next_token = "NextToken",
        .resource_type = "ResourceType",
        .state = "State",
    };
};

pub const ListCopyJobSummariesOutput = struct {
    /// The period for the returned results.
    ///
    /// * `ONE_DAY` - The daily job count for the prior 14 days.
    ///
    /// * `SEVEN_DAYS` - The aggregated job count for the prior 7 days.
    ///
    /// * `FOURTEEN_DAYS` - The aggregated job count for prior 14 days.
    aggregation_period: ?[]const u8 = null,

    /// This return shows a summary that contains
    /// Region, Account, State, ResourceType, MessageCategory,
    /// StartTime, EndTime, and Count of included jobs.
    copy_job_summaries: ?[]const CopyJobSummary = null,

    /// The next item following a partial list of returned resources. For example,
    /// if a request
    /// is made to return `MaxResults` number of resources, `NextToken`
    /// allows you to return more items in your list starting at the location
    /// pointed to by the
    /// next token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_period = "AggregationPeriod",
        .copy_job_summaries = "CopyJobSummaries",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCopyJobSummariesInput, options: Options) !ListCopyJobSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backup");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListCopyJobSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/audit/copy-job-summaries";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "AccountId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.aggregation_period) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "AggregationPeriod=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.message_category) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "MessageCategory=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "NextToken=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "ResourceType=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "State=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListCopyJobSummariesOutput {
    var result: ListCopyJobSummariesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCopyJobSummariesOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
