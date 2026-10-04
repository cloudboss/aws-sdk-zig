const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQuotaUtilizationReportInput, options: CallOptions) !GetQuotaUtilizationReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicequotas", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQuotaUtilizationReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicequotas", "Service Quotas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ServiceQuotasV20190624.GetQuotaUtilizationReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQuotaUtilizationReportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQuotaUtilizationReportOutput, body, allocator);
}
