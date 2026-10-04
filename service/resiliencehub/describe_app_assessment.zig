const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppAssessment = @import("app_assessment.zig").AppAssessment;

pub const DescribeAppAssessmentInput = struct {
    /// Amazon Resource Name (ARN) of the assessment. The format for this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app-assessment/`app-id`.
    /// For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    assessment_arn: []const u8,

    pub const json_field_names = .{
        .assessment_arn = "assessmentArn",
    };
};

pub const DescribeAppAssessmentOutput = struct {
    /// The assessment for an Resilience Hub application, returned as an object.
    /// This
    /// object includes Amazon Resource Names (ARNs), compliance information,
    /// compliance status, cost,
    /// messages, resiliency scores, and more.
    assessment: ?AppAssessment = null,

    pub const json_field_names = .{
        .assessment = "assessment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAppAssessmentInput, options: CallOptions) !DescribeAppAssessmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAppAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-app-assessment";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assessmentArn\":");
    try aws.json.writeValue(@TypeOf(input.assessment_arn), input.assessment_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAppAssessmentOutput {
    var result: DescribeAppAssessmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAppAssessmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
