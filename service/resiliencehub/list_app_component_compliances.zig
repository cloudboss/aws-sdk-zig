const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppComponentCompliance = @import("app_component_compliance.zig").AppComponentCompliance;

pub const ListAppComponentCompliancesInput = struct {
    /// Amazon Resource Name (ARN) of the assessment. The format for this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app-assessment/`app-id`.
    /// For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    assessment_arn: []const u8,

    /// Maximum number of results to include in the response. If more results exist
    /// than the specified
    /// `MaxResults` value, a token is included in the response so that the
    /// remaining results can be retrieved.
    max_results: ?i32 = null,

    /// Null, or the token from a previous call to get the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_arn = "assessmentArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAppComponentCompliancesOutput = struct {
    /// The compliances for an Resilience Hub Application Component, returned as an
    /// object. This
    /// object contains the names of the Application Components, compliances, costs,
    /// resiliency scores,
    /// outage scores, and more.
    component_compliances: ?[]const AppComponentCompliance = null,

    /// Token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_compliances = "componentCompliances",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppComponentCompliancesInput, options: CallOptions) !ListAppComponentCompliancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppComponentCompliancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-app-component-compliances";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assessmentArn\":");
    try aws.json.writeValue(@TypeOf(input.assessment_arn), input.assessment_arn, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppComponentCompliancesOutput {
    const result: ListAppComponentCompliancesOutput = try aws.json.parseJsonObject(
        ListAppComponentCompliancesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
