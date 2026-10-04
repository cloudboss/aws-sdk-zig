const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommenderFilterStatus = @import("recommender_filter_status.zig").RecommenderFilterStatus;

pub const GetRecommenderFilterInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The name of the recommender filter to retrieve.
    recommender_filter_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .recommender_filter_name = "RecommenderFilterName",
    };
};

pub const GetRecommenderFilterOutput = struct {
    /// The timestamp of when the recommender filter was created.
    created_at: i64,

    /// The description of the recommender filter.
    description: ?[]const u8 = null,

    /// If the recommender filter failed, provides the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The filter expression that defines which items to include or exclude from
    /// recommendations.
    recommender_filter_expression: []const u8,

    /// The name of the recommender filter.
    recommender_filter_name: []const u8,

    /// The name of the recommender schema associated with this recommender filter.
    recommender_schema_name: ?[]const u8 = null,

    /// The status of the recommender filter.
    status: RecommenderFilterStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .failure_reason = "FailureReason",
        .recommender_filter_expression = "RecommenderFilterExpression",
        .recommender_filter_name = "RecommenderFilterName",
        .recommender_schema_name = "RecommenderSchemaName",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommenderFilterInput, options: CallOptions) !GetRecommenderFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommenderFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/recommender-filters/");
    try path_buf.appendSlice(allocator, input.recommender_filter_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommenderFilterOutput {
    var result: GetRecommenderFilterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRecommenderFilterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
