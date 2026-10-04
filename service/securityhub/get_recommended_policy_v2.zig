const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationError = @import("recommendation_error.zig").RecommendationError;
const RecommendationStep = @import("recommendation_step.zig").RecommendationStep;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;

pub const GetRecommendedPolicyV2Input = struct {
    /// The maximum number of recommendation steps to return.
    max_results: ?i32 = null,

    /// The unique identifier (ID) of Security Hub OCSF findings found under the
    /// `metadata.uid` field of the finding.
    metadata_uid: []const u8,

    /// The token used to paginate the `RecommendationSteps` list returned.
    /// On your first call to `GetRecommendedPolicyV2`, omit this parameter or set
    /// it
    /// to `NULL`. For subsequent calls, use the `NextToken` value returned in
    /// the previous response to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .metadata_uid = "MetadataUid",
        .next_token = "NextToken",
    };
};

pub const GetRecommendedPolicyV2Output = struct {
    /// Detailed information for a `FAILED` retrieval status.
    @"error": ?RecommendationError = null,

    /// The pagination token to use to request the next page of results.
    next_token: ?[]const u8 = null,

    /// The recommended steps to take to resolve the finding.
    recommendation_steps: ?[]const RecommendationStep = null,

    /// The type of recommendation for the finding.
    recommendation_type: ?RecommendationType = null,

    /// The ARN of the resource of the finding.
    resource_arn: ?[]const u8 = null,

    /// The current status of the recommended policy retrieval.
    status: ?RecommendationStatus = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .next_token = "NextToken",
        .recommendation_steps = "RecommendationSteps",
        .recommendation_type = "RecommendationType",
        .resource_arn = "ResourceArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendedPolicyV2Input, options: CallOptions) !GetRecommendedPolicyV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendedPolicyV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/recommendedPolicyV2/");
    try path_buf.appendSlice(allocator, input.metadata_uid);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendedPolicyV2Output {
    const result: GetRecommendedPolicyV2Output = try aws.json.parseJsonObject(
        GetRecommendedPolicyV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
