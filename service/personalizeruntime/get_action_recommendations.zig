const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PredictedAction = @import("predicted_action.zig").PredictedAction;

pub const GetActionRecommendationsInput = struct {
    /// The Amazon Resource Name (ARN) of the campaign to use for getting action
    /// recommendations. This campaign must deploy a solution version trained with a
    /// PERSONALIZED_ACTIONS recipe.
    campaign_arn: ?[]const u8 = null,

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
    /// For filter expressions that use an `INCLUDE` element to include actions,
    /// you must provide values for all parameters that are defined in the
    /// expression. For
    /// filters with expressions that use an `EXCLUDE` element to exclude actions,
    /// you
    /// can omit the `filter-values`. In this case, Amazon Personalize doesn't use
    /// that portion of
    /// the expression to filter recommendations.
    ///
    /// For more information, see
    /// [Filtering recommendations and user
    /// segments](https://docs.aws.amazon.com/personalize/latest/dg/filter.html).
    filter_values: ?[]const aws.map.StringMapEntry = null,

    /// The number of results to return. The default is 5. The maximum is 100.
    num_results: i32 = 0,

    /// The user ID of the user to provide action recommendations for.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .campaign_arn = "campaignArn",
        .filter_arn = "filterArn",
        .filter_values = "filterValues",
        .num_results = "numResults",
        .user_id = "userId",
    };
};

pub const GetActionRecommendationsOutput = struct {
    /// A list of action recommendations sorted in descending order by prediction
    /// score. There can be a maximum of 100 actions
    /// in the list. For information about action scores, see [How action
    /// recommendation scoring
    /// works](https://docs.aws.amazon.com/personalize/latest/dg/how-action-recommendation-scoring-works.html).
    action_list: ?[]const PredictedAction = null,

    /// The ID of the recommendation.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_list = "actionList",
        .recommendation_id = "recommendationId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetActionRecommendationsInput, options: Options) !GetActionRecommendationsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetActionRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalizeruntime", "Personalize Runtime", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/action-recommendations";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.campaign_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"campaignArn\":");
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
    if (input.num_results) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"numResults\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.user_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"userId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetActionRecommendationsOutput {
    var result: GetActionRecommendationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetActionRecommendationsOutput, body, alloc);
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
