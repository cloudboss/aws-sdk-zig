const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DependencyConfig = @import("dependency_config.zig").DependencyConfig;
const MetricSourceType = @import("metric_source_type.zig").MetricSourceType;
const ServiceLevelObjectiveSummary = @import("service_level_objective_summary.zig").ServiceLevelObjectiveSummary;

pub const ListServiceLevelObjectivesInput = struct {
    /// Identifies the dependency using the `DependencyKeyAttributes` and
    /// `DependencyOperationName`.
    dependency_config: ?DependencyConfig = null,

    /// If you are using this operation in a monitoring account, specify `true` to
    /// include SLO from source accounts in the returned data.
    ///
    /// When you are monitoring an account, you can use Amazon Web Services account
    /// ID in `KeyAttribute` filter for service source account and
    /// `SloOwnerawsaccountID` for SLO source account with `IncludeLinkedAccounts`
    /// to filter the returned data to only a single source account.
    include_linked_accounts: ?bool = null,

    /// You can use this optional field to specify which services you want to
    /// retrieve SLO information for.
    ///
    /// This is a string-to-string map. It can include the following fields.
    ///
    /// * `Type` designates the type of object this is.
    /// * `ResourceType` specifies the type of the resource. This field is used only
    ///   when the value of the `Type` field is `Resource` or `AWS::Resource`.
    /// * `Name` specifies the name of the object. This is used only if the value of
    ///   the `Type` field is `Service`, `RemoteService`, or `AWS::Service`.
    /// * `Identifier` identifies the resource objects of this resource. This is
    ///   used only if the value of the `Type` field is `Resource` or
    ///   `AWS::Resource`.
    /// * `Environment` specifies the location where this object is hosted, or what
    ///   it belongs to.
    key_attributes: ?[]const aws.map.StringMapEntry = null,

    /// The maximum number of results to return in one operation. If you omit this
    /// parameter, the default of 50 is used.
    max_results: ?i32 = null,

    /// Use this optional field to only include SLOs with the specified metric
    /// source types in the output. Supported types are:
    ///
    /// * Service operation
    /// * Service dependency
    /// * CloudWatch metric
    metric_source_types: ?[]const MetricSourceType = null,

    /// Include this value, if it was returned by the previous operation, to get the
    /// next set of service level objectives.
    next_token: ?[]const u8 = null,

    /// The name of the operation that this SLO is associated with.
    operation_name: ?[]const u8 = null,

    /// SLO's Amazon Web Services account ID.
    slo_owner_aws_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .dependency_config = "DependencyConfig",
        .include_linked_accounts = "IncludeLinkedAccounts",
        .key_attributes = "KeyAttributes",
        .max_results = "MaxResults",
        .metric_source_types = "MetricSourceTypes",
        .next_token = "NextToken",
        .operation_name = "OperationName",
        .slo_owner_aws_account_id = "SloOwnerAwsAccountId",
    };
};

pub const ListServiceLevelObjectivesOutput = struct {
    /// Include this value in your next use of this API to get next set of service
    /// level objectives.
    next_token: ?[]const u8 = null,

    /// An array of structures, where each structure contains information about one
    /// SLO.
    slo_summaries: ?[]const ServiceLevelObjectiveSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .slo_summaries = "SloSummaries",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceLevelObjectivesInput, options: Options) !ListServiceLevelObjectivesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationsignals");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceLevelObjectivesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationsignals", "Application Signals", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/slos";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.include_linked_accounts) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "IncludeLinkedAccounts=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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
    if (input.operation_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OperationName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.slo_owner_aws_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "SloOwnerAwsAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dependency_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DependencyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.key_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KeyAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metric_source_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MetricSourceTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceLevelObjectivesOutput {
    var result: ListServiceLevelObjectivesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListServiceLevelObjectivesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
