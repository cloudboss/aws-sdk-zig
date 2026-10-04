const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightsByAssessment = @import("insights_by_assessment.zig").InsightsByAssessment;

pub const GetInsightsByAssessmentInput = struct {
    /// The unique identifier for the assessment.
    assessment_id: []const u8,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
    };
};

pub const GetInsightsByAssessmentOutput = struct {
    /// The assessment analytics data that the `GetInsightsByAssessment` API
    /// returned.
    insights: ?InsightsByAssessment = null,

    pub const json_field_names = .{
        .insights = "insights",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInsightsByAssessmentInput, options: CallOptions) !GetInsightsByAssessmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "auditmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInsightsByAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/insights/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInsightsByAssessmentOutput {
    var result: GetInsightsByAssessmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInsightsByAssessmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
