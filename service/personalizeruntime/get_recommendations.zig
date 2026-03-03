const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Promotion = @import("promotion.zig").Promotion;
const PredictedItem = @import("predicted_item.zig").PredictedItem;

pub const GetRecommendationsInput = struct {
    /// The Amazon Resource Name (ARN) of the campaign to use for getting
    /// recommendations.
    campaign_arn: ?[]const u8 = null,

    /// The contextual metadata to use when getting recommendations. Contextual
    /// metadata includes
    /// any interaction information that might be relevant when getting a user's
    /// recommendations, such
    /// as the user's current location or device type.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the filter to apply to the returned recommendations. For more
    /// information, see
    /// [Filtering
    /// Recommendations](https://docs.aws.amazon.com/personalize/latest/dg/filter.html).
    ///
    /// When using this parameter, be sure the filter resource is `ACTIVE`.
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
    /// [Filtering recommendations and user
    /// segments](https://docs.aws.amazon.com/personalize/latest/dg/filter.html).
    filter_values: ?[]const aws.map.StringMapEntry = null,

    /// The item ID to provide recommendations for.
    ///
    /// Required for `RELATED_ITEMS` recipe type.
    item_id: ?[]const u8 = null,

    /// If you enabled metadata in recommendations when you created or updated the
    /// campaign or recommender, specify the metadata columns from your Items
    /// dataset to include in item recommendations.
    /// The map key is `ITEMS` and the value is a list of column names from your
    /// Items dataset.
    /// The maximum number of columns you can provide is 10.
    ///
    /// For information about enabling metadata for a campaign, see [Enabling
    /// metadata in recommendations for a
    /// campaign](https://docs.aws.amazon.com/personalize/latest/dg/campaigns.html#create-campaign-return-metadata).
    /// For information about enabling metadata for a recommender, see [Enabling
    /// metadata in recommendations for a
    /// recommender](https://docs.aws.amazon.com/personalize/latest/dg/creating-recommenders.html#create-recommender-return-metadata).
    metadata_columns: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The number of results to return. The default is 25. If you are including
    /// metadata in recommendations, the maximum is 50. Otherwise, the maximum is
    /// 500.
    num_results: ?i32 = null,

    /// The promotions to apply to the recommendation request.
    /// A promotion defines additional business rules that apply to a configurable
    /// subset of recommended items.
    promotions: ?[]const Promotion = null,

    /// The Amazon Resource Name (ARN) of the recommender to use to get
    /// recommendations. Provide a recommender ARN if you
    /// created a Domain dataset group with a recommender for a domain use case.
    recommender_arn: ?[]const u8 = null,

    /// The user ID to provide recommendations for.
    ///
    /// Required for `USER_PERSONALIZATION` recipe type.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .campaign_arn = "campaignArn",
        .context = "context",
        .filter_arn = "filterArn",
        .filter_values = "filterValues",
        .item_id = "itemId",
        .metadata_columns = "metadataColumns",
        .num_results = "numResults",
        .promotions = "promotions",
        .recommender_arn = "recommenderArn",
        .user_id = "userId",
    };
};

pub const GetRecommendationsOutput = struct {
    /// A list of recommendations sorted in descending order by prediction score.
    /// There can be a
    /// maximum of 500 items in the list.
    item_list: ?[]const PredictedItem = null,

    /// The ID of the recommendation.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .item_list = "itemList",
        .recommendation_id = "recommendationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationsInput, options: CallOptions) !GetRecommendationsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalizeruntime", "Personalize Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/recommendations";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.campaign_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"campaignArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"context\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterValues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.item_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"itemId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_columns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataColumns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.num_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"numResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.promotions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"promotions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recommender_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recommenderArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendationsOutput {
    var result: GetRecommendationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRecommendationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
