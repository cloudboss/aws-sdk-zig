const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppSummary = @import("app_summary.zig").AppSummary;

pub const ListAppsInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of Resource Groups group that is integrated with
    /// an AppRegistry application. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    aws_application_arn: ?[]const u8 = null,

    /// Lower limit of the range that is used to filter applications based on their
    /// last assessment times.
    from_last_assessment_time: ?i64 = null,

    /// Maximum number of results to include in the response. If more results exist
    /// than the specified
    /// `MaxResults` value, a token is included in the response so that the
    /// remaining results can be retrieved.
    max_results: ?i32 = null,

    /// The name for the one of the listed applications.
    name: ?[]const u8 = null,

    /// Null, or the token from a previous call to get the next set of results.
    next_token: ?[]const u8 = null,

    /// The application list is sorted based on the values of
    /// `lastAppComplianceEvaluationTime` field. By default, application list is
    /// sorted
    /// in ascending order. To sort the application list in descending order, set
    /// this field to
    /// `True`.
    reverse_order: ?bool = null,

    /// Upper limit of the range that is used to filter the applications based on
    /// their last assessment times.
    to_last_assessment_time: ?i64 = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .aws_application_arn = "awsApplicationArn",
        .from_last_assessment_time = "fromLastAssessmentTime",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .reverse_order = "reverseOrder",
        .to_last_assessment_time = "toLastAssessmentTime",
    };
};

pub const ListAppsOutput = struct {
    /// Summaries for the Resilience Hub application.
    app_summaries: ?[]const AppSummary = null,

    /// Token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_summaries = "appSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppsInput, options: CallOptions) !ListAppsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-apps";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.app_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "appArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.aws_application_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "awsApplicationArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.from_last_assessment_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "fromLastAssessmentTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.to_last_assessment_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "toLastAssessmentTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppsOutput {
    var result: ListAppsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAppsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
