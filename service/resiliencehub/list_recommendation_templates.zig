const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationTemplateStatus = @import("recommendation_template_status.zig").RecommendationTemplateStatus;
const RecommendationTemplate = @import("recommendation_template.zig").RecommendationTemplate;

pub const ListRecommendationTemplatesInput = struct {
    /// Amazon Resource Name (ARN) of the assessment. The format for this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app-assessment/`app-id`.
    /// For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    assessment_arn: ?[]const u8 = null,

    /// Maximum number of results to include in the response. If more results exist
    /// than the specified
    /// `MaxResults` value, a token is included in the response so that the
    /// remaining results can be retrieved.
    max_results: ?i32 = null,

    /// The name for one of the listed recommendation templates.
    name: ?[]const u8 = null,

    /// Null, or the token from a previous call to get the next set of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for a recommendation template.
    recommendation_template_arn: ?[]const u8 = null,

    /// The default is to sort by ascending **startTime**.
    /// To sort by descending **startTime**, set reverseOrder to `true`.
    reverse_order: ?bool = null,

    /// Status of the action.
    status: ?[]const RecommendationTemplateStatus = null,

    pub const json_field_names = .{
        .assessment_arn = "assessmentArn",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .recommendation_template_arn = "recommendationTemplateArn",
        .reverse_order = "reverseOrder",
        .status = "status",
    };
};

pub const ListRecommendationTemplatesOutput = struct {
    /// Token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    /// The recommendation templates for the Resilience Hub applications.
    recommendation_templates: ?[]const RecommendationTemplate = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .recommendation_templates = "recommendationTemplates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendationTemplatesInput, options: CallOptions) !ListRecommendationTemplatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendationTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-recommendation-templates";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.assessment_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assessmentArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.recommendation_template_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "recommendationTemplateArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.reverse_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "reverseOrder=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.status) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "status=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecommendationTemplatesOutput {
    const result: ListRecommendationTemplatesOutput = try aws.json.parseJsonObject(
        ListRecommendationTemplatesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
