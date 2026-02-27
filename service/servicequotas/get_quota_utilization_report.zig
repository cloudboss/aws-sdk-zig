const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const QuotaUtilizationInfo = @import("quota_utilization_info.zig").QuotaUtilizationInfo;
const ReportStatus = @import("report_status.zig").ReportStatus;

pub const GetQuotaUtilizationReportInput = struct {
    /// The maximum number of results to return per page. The default value is 1,000
    /// and the
    /// maximum allowed value is 1,000.
    max_results: ?i32 = null,

    /// A token that indicates the next page of results to retrieve. This token is
    /// returned in
    /// the response when there are more results available. Omit this parameter for
    /// the first request.
    next_token: ?[]const u8 = null,

    /// The unique identifier for the quota utilization report. This identifier is
    /// returned by
    /// the `StartQuotaUtilizationReport` operation.
    report_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .report_id = "ReportId",
    };
};

pub const GetQuotaUtilizationReportOutput = struct {
    /// An error code indicating the reason for failure when the report status is
    /// `FAILED`.
    /// This field is only present when the status is `FAILED`.
    error_code: ?[]const u8 = null,

    /// A detailed error message describing the failure when the report status is
    /// `FAILED`.
    /// This field is only present when the status is `FAILED`.
    error_message: ?[]const u8 = null,

    /// The timestamp when the report was generated, in ISO 8601 format.
    generated_at: ?i64 = null,

    /// A token that indicates more results are available. Include this token in the
    /// next request
    /// to retrieve the next page of results. If this field is not present, you have
    /// retrieved all
    /// available results.
    next_token: ?[]const u8 = null,

    /// A list of quota utilization records, sorted by utilization percentage in
    /// descending order.
    /// Each record includes the quota code, service code, service name, quota name,
    /// namespace,
    /// utilization percentage, default value, applied value, and whether the quota
    /// is adjustable.
    /// Up to 1,000 records are returned per page.
    quotas: ?[]const QuotaUtilizationInfo = null,

    /// The unique identifier for the quota utilization report.
    report_id: ?[]const u8 = null,

    /// The current status of the report generation. Possible values are:
    ///
    /// * `PENDING` - The report generation is in progress. Retry this operation
    /// after a few seconds.
    ///
    /// * `IN_PROGRESS` - The report is being processed. Continue polling until
    /// the status changes to `COMPLETED`.
    ///
    /// * `COMPLETED` - The report is ready and quota utilization data is available
    /// in the response.
    ///
    /// * `FAILED` - The report generation failed. Check the `ErrorCode`
    /// and `ErrorMessage` fields for details.
    status: ?ReportStatus = null,

    /// The total number of quotas included in the report across all pages.
    total_count: ?i32 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .generated_at = "GeneratedAt",
        .next_token = "NextToken",
        .quotas = "Quotas",
        .report_id = "ReportId",
        .status = "Status",
        .total_count = "TotalCount",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQuotaUtilizationReportInput, options: Options) !GetQuotaUtilizationReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "servicequotas");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetQuotaUtilizationReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicequotas", "Service Quotas", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "ServiceQuotasV20190624.GetQuotaUtilizationReport");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetQuotaUtilizationReportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQuotaUtilizationReportOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AWSServiceAccessNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .aws_service_access_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .dependency_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalArgumentException")) {
        return .{ .arena = arena, .kind = .{ .illegal_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "NoAvailableOrganizationException")) {
        return .{ .arena = arena, .kind = .{ .no_available_organization_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchResourceException")) {
        return .{ .arena = arena, .kind = .{ .no_such_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotInAllFeaturesModeException")) {
        return .{ .arena = arena, .kind = .{ .organization_not_in_all_features_mode_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaTemplateNotInUseException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_template_not_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyViolationException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TemplatesNotAvailableInRegionException")) {
        return .{ .arena = arena, .kind = .{ .templates_not_available_in_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
