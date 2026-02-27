const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RDSDBRecommendationFilter = @import("rdsdb_recommendation_filter.zig").RDSDBRecommendationFilter;
const RecommendationPreferences = @import("recommendation_preferences.zig").RecommendationPreferences;
const GetRecommendationError = @import("get_recommendation_error.zig").GetRecommendationError;
const RDSDBRecommendation = @import("rdsdb_recommendation.zig").RDSDBRecommendation;

pub const GetRDSDatabaseRecommendationsInput = struct {
    /// Return the Amazon Aurora and RDS database recommendations to the specified
    /// Amazon Web Services account IDs.
    ///
    /// If your account is the management account or the delegated administrator
    /// of an organization, use this parameter to return the Amazon Aurora and RDS
    /// database recommendations to specific
    /// member accounts.
    ///
    /// You can only specify one account ID per request.
    account_ids: ?[]const []const u8 = null,

    /// An array of objects to specify a filter that returns a more specific list of
    /// Amazon Aurora and RDS database recommendations.
    filters: ?[]const RDSDBRecommendationFilter = null,

    /// The maximum number of Amazon Aurora and RDS database recommendations to
    /// return with a single
    /// request.
    ///
    /// To retrieve the remaining results, make another request with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The token to advance to the next page of Amazon Aurora and RDS database
    /// recommendations.
    next_token: ?[]const u8 = null,

    recommendation_preferences: ?RecommendationPreferences = null,

    /// The ARN that identifies the Amazon Aurora or RDS database.
    ///
    /// The following is the format of the ARN:
    ///
    /// `arn:aws:rds:{region}:{accountId}:db:{resourceName}`
    ///
    /// The following is the format of a DB Cluster ARN:
    ///
    /// `arn:aws:rds:{region}:{accountId}:cluster:{resourceName}`
    resource_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .recommendation_preferences = "recommendationPreferences",
        .resource_arns = "resourceArns",
    };
};

pub const GetRDSDatabaseRecommendationsOutput = struct {
    /// An array of objects that describe errors of the request.
    errors: ?[]const GetRecommendationError = null,

    /// The token to advance to the next page of Amazon Aurora and RDS database
    /// recommendations.
    next_token: ?[]const u8 = null,

    /// An array of objects that describe the Amazon Aurora and RDS database
    /// recommendations.
    rds_db_recommendations: ?[]const RDSDBRecommendation = null,

    pub const json_field_names = .{
        .errors = "errors",
        .next_token = "nextToken",
        .rds_db_recommendations = "rdsDBRecommendations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRDSDatabaseRecommendationsInput, options: Options) !GetRDSDatabaseRecommendationsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetRDSDatabaseRecommendationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "ComputeOptimizerService.GetRDSDatabaseRecommendations");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetRDSDatabaseRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRDSDatabaseRecommendationsOutput, body, alloc);
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
