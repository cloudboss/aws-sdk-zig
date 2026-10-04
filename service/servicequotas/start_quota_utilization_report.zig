const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportStatus = @import("report_status.zig").ReportStatus;

pub const StartQuotaUtilizationReportInput = struct {
};

pub const StartQuotaUtilizationReportOutput = struct {
    /// An optional message providing additional information about the report
    /// generation status.
    /// This field may contain details about the report initiation or indicate if an
    /// existing recent
    /// report is being reused.
    message: ?[]const u8 = null,

    /// A unique identifier for the quota utilization report. Use this identifier
    /// with the
    /// `GetQuotaUtilizationReport` operation to retrieve the report results.
    report_id: ?[]const u8 = null,

    /// The current status of the report generation. The status will be `PENDING`
    /// when the report is first initiated.
    status: ?ReportStatus = null,

    pub const json_field_names = .{
        .message = "Message",
        .report_id = "ReportId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQuotaUtilizationReportInput, options: CallOptions) !StartQuotaUtilizationReportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQuotaUtilizationReportInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("servicequotas", "Service Quotas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ServiceQuotasV20190624.StartQuotaUtilizationReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQuotaUtilizationReportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartQuotaUtilizationReportOutput, body, allocator);
}
