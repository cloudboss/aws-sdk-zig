const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const RecommendationPreferences = @import("recommendation_preferences.zig").RecommendationPreferences;
const AutoScalingGroupRecommendation = @import("auto_scaling_group_recommendation.zig").AutoScalingGroupRecommendation;
const GetRecommendationError = @import("get_recommendation_error.zig").GetRecommendationError;

pub const GetAutoScalingGroupRecommendationsInput = struct {
    /// The ID of the Amazon Web Services account for which to return Amazon EC2
    /// Auto Scaling group
    /// recommendations.
    ///
    /// If your account is the management account of an organization, use this
    /// parameter to
    /// specify the member account for which you want to return Amazon EC2 Auto
    /// Scaling group
    /// recommendations.
    ///
    /// Only one account ID can be specified per request.
    account_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon EC2 Auto Scaling groups for
    /// which to return
    /// recommendations.
    auto_scaling_group_arns: ?[]const []const u8 = null,

    /// An array of objects to specify a filter that returns a more specific list of
    /// Amazon EC2 Auto Scaling group recommendations.
    filters: ?[]const Filter = null,

    /// The maximum number of Amazon EC2 Auto Scaling group recommendations to
    /// return with a single
    /// request.
    ///
    /// To retrieve the remaining results, make another request with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The token to advance to the next page of Amazon EC2 Auto Scaling group
    /// recommendations.
    next_token: ?[]const u8 = null,

    /// An object to specify the preferences for the Amazon EC2 Auto Scaling group
    /// recommendations
    /// to return in the response.
    recommendation_preferences: ?RecommendationPreferences = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .auto_scaling_group_arns = "autoScalingGroupArns",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .recommendation_preferences = "recommendationPreferences",
    };
};

pub const GetAutoScalingGroupRecommendationsOutput = struct {
    /// An array of objects that describe Amazon EC2 Auto Scaling group
    /// recommendations.
    auto_scaling_group_recommendations: ?[]const AutoScalingGroupRecommendation = null,

    /// An array of objects that describe errors of the request.
    ///
    /// For example, an error is returned if you request recommendations for an
    /// unsupported
    /// Amazon EC2 Auto Scaling group.
    errors: ?[]const GetRecommendationError = null,

    /// The token to use to advance to the next page of Amazon EC2 Auto Scaling
    /// group
    /// recommendations.
    ///
    /// This value is null when there are no more pages of Amazon EC2 Auto Scaling
    /// group
    /// recommendations to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_scaling_group_recommendations = "autoScalingGroupRecommendations",
        .errors = "errors",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutoScalingGroupRecommendationsInput, options: Options) !GetAutoScalingGroupRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "computeoptimizer");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetAutoScalingGroupRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("computeoptimizer", "Compute Optimizer", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "ComputeOptimizerService.GetAutoScalingGroupRecommendations");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAutoScalingGroupRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAutoScalingGroupRecommendationsOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingAuthenticationToken")) {
        return .{ .arena = arena, .kind = .{ .missing_authentication_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptInRequiredException")) {
        return .{ .arena = arena, .kind = .{ .opt_in_required_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
