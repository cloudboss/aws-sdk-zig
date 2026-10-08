const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DependencyInsightsErrorCode = @import("dependency_insights_error_code.zig").DependencyInsightsErrorCode;
const DependencyInsight = @import("dependency_insight.zig").DependencyInsight;
const DependencyInsightsStatus = @import("dependency_insights_status.zig").DependencyInsightsStatus;

pub const GetDependencyInsightsInput = struct {
    service_arn: []const u8,

    pub const json_field_names = .{
        .service_arn = "serviceArn",
    };
};

pub const GetDependencyInsightsOutput = struct {
    /// The timestamp when the dependency insights were generated.
    created_at: ?i64 = null,

    /// The error code returned when insights generation failed. Valid values:
    ///
    /// * INSUFFICIENT_DATA - There was not enough dependency data to generate
    ///   insights.
    /// * LLM_GENERATION_FAILED - The insights could not be generated.
    /// * INTERNAL_ERROR - An internal error occurred while generating insights.
    error_code: ?DependencyInsightsErrorCode = null,

    /// A message describing why insights generation failed.
    error_message: ?[]const u8 = null,

    /// The list of dependency insights generated for the service. This field is not
    /// returned until the status is COMPLETED.
    insights: ?[]const DependencyInsight = null,

    /// A summary of the dependency insights for the service. This field is not
    /// returned until the status is COMPLETED.
    overview: ?[]const u8 = null,

    /// The status of the dependency insights generation. Valid values:
    ///
    /// * IN_PROGRESS - Insights generation is in progress.
    /// * COMPLETED - Insights generation completed successfully.
    /// * FAILED - Insights generation failed. See errorCode and errorMessage for
    ///   details.
    status: DependencyInsightsStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .insights = "insights",
        .overview = "overview",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDependencyInsightsInput, options: CallOptions) !GetDependencyInsightsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDependencyInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/get-dependency-insights";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "serviceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.service_arn);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDependencyInsightsOutput {
    const result: GetDependencyInsightsOutput = try aws.json.parseJsonObject(
        GetDependencyInsightsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
