const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PredictedItem = @import("predicted_item.zig").PredictedItem;

pub const GetPersonalizedRankingInput = struct {
    /// The Amazon Resource Name (ARN) of the campaign to use for generating the
    /// personalized
    /// ranking.
    campaign_arn: []const u8,

    /// The contextual metadata to use when getting recommendations. Contextual
    /// metadata includes
    /// any interaction information that might be relevant when getting a user's
    /// recommendations, such
    /// as the user's current location or device type.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of a filter you created to include items or
    /// exclude items from recommendations for a given user.
    /// For more information, see
    /// [Filtering
    /// Recommendations](https://docs.aws.amazon.com/personalize/latest/dg/filter.html).
    filter_arn: ?[]const u8 = null,

    /// The values to use when filtering recommendations. For each placeholder
    /// parameter in your filter expression, provide the parameter name (in matching
    /// case)
    /// as a key and the filter value(s) as the corresponding value. Separate
    /// multiple values for one parameter with a comma.
    ///
    /// For filter expressions that use an `INCLUDE` element to include items,
    /// you must provide values for all parameters that are defined in the
    /// expression. For
    /// filters with expressions that use an `EXCLUDE` element to exclude items, you
    /// can omit the `filter-values`.In this case, Amazon Personalize doesn't use
    /// that portion of
    /// the expression to filter recommendations.
    ///
    /// For more information, see
    /// [Filtering
    /// Recommendations](https://docs.aws.amazon.com/personalize/latest/dg/filter.html).
    filter_values: ?[]const aws.map.StringMapEntry = null,

    /// A list of items (by `itemId`) to rank. If an item was not included in the
    /// training dataset,
    /// the item is appended to the end of the reranked list. If you are including
    /// metadata in recommendations, the maximum is 50. Otherwise, the maximum is
    /// 500.
    input_list: []const []const u8,

    /// If you enabled metadata in recommendations when you created or updated the
    /// campaign, specify metadata columns from your Items dataset to include
    /// in the personalized ranking.
    /// The map key is `ITEMS` and the value is a list of column names from your
    /// Items dataset.
    /// The maximum number of columns you can provide is 10.
    ///
    /// For information about enabling metadata for a campaign, see [Enabling
    /// metadata in recommendations for a
    /// campaign](https://docs.aws.amazon.com/personalize/latest/dg/campaigns.html#create-campaign-return-metadata).
    metadata_columns: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The user for which you want the campaign to provide a personalized ranking.
    user_id: []const u8,

    pub const json_field_names = .{
        .campaign_arn = "campaignArn",
        .context = "context",
        .filter_arn = "filterArn",
        .filter_values = "filterValues",
        .input_list = "inputList",
        .metadata_columns = "metadataColumns",
        .user_id = "userId",
    };
};

pub const GetPersonalizedRankingOutput = struct {
    /// A list of items in order of most likely interest to the user. The maximum is
    /// 500.
    personalized_ranking: ?[]const PredictedItem = null,

    /// The ID of the recommendation.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .personalized_ranking = "personalizedRanking",
        .recommendation_id = "recommendationId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPersonalizedRankingInput, options: Options) !GetPersonalizedRankingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "personalizeruntime");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetPersonalizedRankingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalizeruntime", "Personalize Runtime", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/personalize-ranking";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"campaignArn\":");
    try aws.json.writeValue(@TypeOf(input.campaign_arn), input.campaign_arn, alloc, &body_buf);
    has_prev = true;
    if (input.context) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"context\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.filter_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"filterArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.filter_values) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"filterValues\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"inputList\":");
    try aws.json.writeValue(@TypeOf(input.input_list), input.input_list, alloc, &body_buf);
    has_prev = true;
    if (input.metadata_columns) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"metadataColumns\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"userId\":");
    try aws.json.writeValue(@TypeOf(input.user_id), input.user_id, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetPersonalizedRankingOutput {
    var result: GetPersonalizedRankingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPersonalizedRankingOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
