const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateRecommenderFilterInput = struct {
    /// A description of the recommender filter.
    description: ?[]const u8 = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// The filter expression that defines which items to include or exclude from
    /// recommendations.
    recommender_filter_expression: []const u8,

    /// The name of the recommender filter. The name must be unique within the
    /// domain.
    recommender_filter_name: []const u8,

    /// The name of the recommender schema to use for this recommender filter. If
    /// not specified, the default schema is used.
    recommender_schema_name: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .domain_name = "DomainName",
        .recommender_filter_expression = "RecommenderFilterExpression",
        .recommender_filter_name = "RecommenderFilterName",
        .recommender_schema_name = "RecommenderSchemaName",
        .tags = "Tags",
    };
};

pub const CreateRecommenderFilterOutput = struct {
    /// The Amazon Resource Name (ARN) of the recommender filter.
    recommender_filter_arn: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .recommender_filter_arn = "RecommenderFilterArn",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRecommenderFilterInput, options: CallOptions) !CreateRecommenderFilterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRecommenderFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/recommender-filters/");
    try path_buf.appendSlice(allocator, input.recommender_filter_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecommenderFilterExpression\":");
    try aws.json.writeValue(@TypeOf(input.recommender_filter_expression), input.recommender_filter_expression, allocator, &body_buf);
    has_prev = true;
    if (input.recommender_schema_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RecommenderSchemaName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRecommenderFilterOutput {
    var result: CreateRecommenderFilterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRecommenderFilterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
