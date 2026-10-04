const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisTypeReportResult = @import("analysis_type_report_result.zig").AnalysisTypeReportResult;
const EnabledAnalysisType = @import("enabled_analysis_type.zig").EnabledAnalysisType;

pub const GetAnalysisReportResultsInput = struct {
    /// The unique ID of the query that ran when you requested an analysis report.
    analysis_report_id: []const u8,

    /// The Amazon Resource Name (ARN) of the firewall.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_name: ?[]const u8 = null,

    /// The maximum number of objects that you want Network Firewall to return for
    /// this request. If more
    /// objects are available, in the response, Network Firewall provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    max_results: ?i32 = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Network Firewall returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_report_id = "AnalysisReportId",
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetAnalysisReportResultsOutput = struct {
    /// Retrieves the results of a traffic analysis report.
    analysis_report_results: ?[]const AnalysisTypeReportResult = null,

    /// The type of traffic that will be used to generate a report.
    analysis_type: ?EnabledAnalysisType = null,

    /// The date and time, up to the current date, from which to stop retrieving
    /// analysis data,
    /// in UTC format (for example, `YYYY-MM-DDTHH:MM:SSZ`).
    end_time: ?i64 = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Network Firewall returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    /// The date and time the analysis report was ran.
    report_time: ?i64 = null,

    /// The date and time within the last 30 days from which to start retrieving
    /// analysis data,
    /// in UTC format (for example, `YYYY-MM-DDTHH:MM:SSZ`.
    start_time: ?i64 = null,

    /// The status of the analysis report you specify. Statuses include `RUNNING`,
    /// `COMPLETED`, or `FAILED`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_report_results = "AnalysisReportResults",
        .analysis_type = "AnalysisType",
        .end_time = "EndTime",
        .next_token = "NextToken",
        .report_time = "ReportTime",
        .start_time = "StartTime",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAnalysisReportResultsInput, options: CallOptions) !GetAnalysisReportResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAnalysisReportResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.GetAnalysisReportResults");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAnalysisReportResultsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAnalysisReportResultsOutput, body, allocator);
}
