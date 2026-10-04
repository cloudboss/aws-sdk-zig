const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;
const AssessmentInvoker = @import("assessment_invoker.zig").AssessmentInvoker;
const AppAssessmentSummary = @import("app_assessment_summary.zig").AppAssessmentSummary;

pub const ListAppAssessmentsInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: ?[]const u8 = null,

    /// The name for the assessment.
    assessment_name: ?[]const u8 = null,

    /// The current status of the assessment for the resiliency policy.
    assessment_status: ?[]const AssessmentStatus = null,

    /// The current status of compliance for the resiliency policy.
    compliance_status: ?ComplianceStatus = null,

    /// Specifies the entity that invoked a specific assessment, either a `User` or
    /// the
    /// `System`.
    invoker: ?AssessmentInvoker = null,

    /// Maximum number of results to include in the response. If more results exist
    /// than the specified
    /// `MaxResults` value, a token is included in the response so that the
    /// remaining results can be retrieved.
    max_results: ?i32 = null,

    /// Null, or the token from a previous call to get the next set of results.
    next_token: ?[]const u8 = null,

    /// The default is to sort by ascending **startTime**.
    /// To sort by descending **startTime**, set reverseOrder to `true`.
    reverse_order: ?bool = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .assessment_name = "assessmentName",
        .assessment_status = "assessmentStatus",
        .compliance_status = "complianceStatus",
        .invoker = "invoker",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .reverse_order = "reverseOrder",
    };
};

pub const ListAppAssessmentsOutput = struct {
    /// The summaries for the specified assessments, returned as an object. This
    /// object includes
    /// application versions, associated Amazon Resource Numbers (ARNs), cost,
    /// messages, resiliency
    /// scores, and more.
    assessment_summaries: ?[]const AppAssessmentSummary = null,

    /// Token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_summaries = "assessmentSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppAssessmentsInput, options: CallOptions) !ListAppAssessmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppAssessmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-app-assessments";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.app_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "appArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.assessment_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assessmentName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.assessment_status) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "assessmentStatus=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.compliance_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "complianceStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.invoker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "invoker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.reverse_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "reverseOrder=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppAssessmentsOutput {
    const result: ListAppAssessmentsOutput = try aws.json.parseJsonObject(
        ListAppAssessmentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
