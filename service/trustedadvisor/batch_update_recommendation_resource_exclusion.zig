const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationResourceExclusion = @import("recommendation_resource_exclusion.zig").RecommendationResourceExclusion;
const UpdateRecommendationResourceExclusionError = @import("update_recommendation_resource_exclusion_error.zig").UpdateRecommendationResourceExclusionError;

pub const BatchUpdateRecommendationResourceExclusionInput = struct {
    /// A list of recommendation resource ARNs and exclusion status to update
    recommendation_resource_exclusions: []const RecommendationResourceExclusion,

    pub const json_field_names = .{
        .recommendation_resource_exclusions = "recommendationResourceExclusions",
    };
};

pub const BatchUpdateRecommendationResourceExclusionOutput = struct {
    /// A list of recommendation resource ARNs whose exclusion status failed to
    /// update, if any
    batch_update_recommendation_resource_exclusion_errors: ?[]const UpdateRecommendationResourceExclusionError = null,

    pub const json_field_names = .{
        .batch_update_recommendation_resource_exclusion_errors = "batchUpdateRecommendationResourceExclusionErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateRecommendationResourceExclusionInput, options: CallOptions) !BatchUpdateRecommendationResourceExclusionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "trustedadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateRecommendationResourceExclusionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("trustedadvisor", "TrustedAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/batch-update-recommendation-resource-exclusion";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"recommendationResourceExclusions\":");
    try aws.json.writeValue(@TypeOf(input.recommendation_resource_exclusions), input.recommendation_resource_exclusions, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateRecommendationResourceExclusionOutput {
    const result: BatchUpdateRecommendationResourceExclusionOutput = try aws.json.parseJsonObject(
        BatchUpdateRecommendationResourceExclusionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
