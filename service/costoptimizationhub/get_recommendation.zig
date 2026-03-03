const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActionType = @import("action_type.zig").ActionType;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const ResourceType = @import("resource_type.zig").ResourceType;
const ImplementationEffort = @import("implementation_effort.zig").ImplementationEffort;
const Source = @import("source.zig").Source;
const Tag = @import("tag.zig").Tag;

pub const GetRecommendationInput = struct {
    /// The ID for the recommendation.
    recommendation_id: []const u8,

    pub const json_field_names = .{
        .recommendation_id = "recommendationId",
    };
};

pub const GetRecommendationOutput = struct {
    /// The account to which the recommendation applies.
    account_id: ?[]const u8 = null,

    /// The type of action you can take by adopting the recommendation.
    action_type: ?ActionType = null,

    /// The lookback period used to calculate cost impact for a recommendation.
    cost_calculation_lookback_period_in_days: ?i32 = null,

    /// The currency code used for the recommendation.
    currency_code: ?[]const u8 = null,

    /// The details for the resource.
    current_resource_details: ?ResourceDetails = null,

    /// The type of resource.
    current_resource_type: ?ResourceType = null,

    /// The estimated monthly cost of the current resource. For Reserved Instances
    /// and Savings Plans, it refers to the cost for eligible usage.
    estimated_monthly_cost: ?f64 = null,

    /// The estimated monthly savings amount for the recommendation.
    estimated_monthly_savings: ?f64 = null,

    /// The estimated savings amount over the lookback period used to calculate cost
    /// impact for a recommendation.
    estimated_savings_over_cost_calculation_lookback_period: ?f64 = null,

    /// The estimated savings percentage relative to the total cost over the cost
    /// calculation lookback period.
    estimated_savings_percentage: ?f64 = null,

    /// The effort required to implement the recommendation.
    implementation_effort: ?ImplementationEffort = null,

    /// The time when the recommendation was last generated.
    last_refresh_timestamp: ?i64 = null,

    /// The ID for the recommendation.
    recommendation_id: ?[]const u8 = null,

    /// The lookback period that's used to generate the recommendation.
    recommendation_lookback_period_in_days: ?i32 = null,

    /// The details about the recommended resource.
    recommended_resource_details: ?ResourceDetails = null,

    /// The resource type of the recommendation.
    recommended_resource_type: ?ResourceType = null,

    /// The Amazon Web Services Region of the resource.
    region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    /// The unique identifier for the resource. This is the same as the Amazon
    /// Resource Name (ARN), if available.
    resource_id: ?[]const u8 = null,

    /// Whether or not implementing the recommendation requires a restart.
    restart_needed: ?bool = null,

    /// Whether or not implementing the recommendation can be rolled back.
    rollback_possible: ?bool = null,

    /// The source of the recommendation.
    source: ?Source = null,

    /// A list of tags associated with the resource for which the recommendation
    /// exists.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .action_type = "actionType",
        .cost_calculation_lookback_period_in_days = "costCalculationLookbackPeriodInDays",
        .currency_code = "currencyCode",
        .current_resource_details = "currentResourceDetails",
        .current_resource_type = "currentResourceType",
        .estimated_monthly_cost = "estimatedMonthlyCost",
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .estimated_savings_over_cost_calculation_lookback_period = "estimatedSavingsOverCostCalculationLookbackPeriod",
        .estimated_savings_percentage = "estimatedSavingsPercentage",
        .implementation_effort = "implementationEffort",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .recommendation_id = "recommendationId",
        .recommendation_lookback_period_in_days = "recommendationLookbackPeriodInDays",
        .recommended_resource_details = "recommendedResourceDetails",
        .recommended_resource_type = "recommendedResourceType",
        .region = "region",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .restart_needed = "restartNeeded",
        .rollback_possible = "rollbackPossible",
        .source = "source",
        .tags = "tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationInput, options: Options) !GetRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "costoptimizationhub");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("costoptimizationhub", "Cost Optimization Hub", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CostOptimizationHubService.GetRecommendation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRecommendationOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
