const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Assessment = @import("assessment.zig").Assessment;
const AssessmentReport = @import("assessment_report.zig").AssessmentReport;

pub const DescribeADAssessmentInput = struct {
    /// The identifier of the directory assessment to describe.
    assessment_id: []const u8,

    pub const json_field_names = .{
        .assessment_id = "AssessmentId",
    };
};

pub const DescribeADAssessmentOutput = struct {
    /// Detailed information about the self-managed instance settings (IDs and DNS
    /// IPs).
    assessment: ?Assessment = null,

    /// A list of assessment reports containing validation results for each domain
    /// controller
    /// and test category. Each report includes specific validation details and
    /// outcomes.
    assessment_reports: ?[]const AssessmentReport = null,

    pub const json_field_names = .{
        .assessment = "Assessment",
        .assessment_reports = "AssessmentReports",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeADAssessmentInput, options: CallOptions) !DescribeADAssessmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeADAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeADAssessment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeADAssessmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeADAssessmentOutput, body, allocator);
}
