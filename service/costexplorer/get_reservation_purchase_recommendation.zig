const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AccountScope = @import("account_scope.zig").AccountScope;
const Expression = @import("expression.zig").Expression;
const LookbackPeriodInDays = @import("lookback_period_in_days.zig").LookbackPeriodInDays;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const ServiceSpecification = @import("service_specification.zig").ServiceSpecification;
const TermInYears = @import("term_in_years.zig").TermInYears;
const ReservationPurchaseRecommendationMetadata = @import("reservation_purchase_recommendation_metadata.zig").ReservationPurchaseRecommendationMetadata;
const ReservationPurchaseRecommendation = @import("reservation_purchase_recommendation.zig").ReservationPurchaseRecommendation;

pub const GetReservationPurchaseRecommendationInput = struct {
    /// The account ID that's associated with the recommendation.
    account_id: ?[]const u8 = null,

    /// The account scope that you want your recommendations for. Amazon Web
    /// Services
    /// calculates recommendations including the management account and member
    /// accounts if the value
    /// is set to `PAYER`. If the value is `LINKED`, recommendations are
    /// calculated for individual member accounts only.
    account_scope: ?AccountScope = null,

    filter: ?Expression = null,

    /// The number of previous days that you want Amazon Web Services to consider
    /// when it
    /// calculates your recommendations.
    lookback_period_in_days: ?LookbackPeriodInDays = null,

    /// The pagination token that indicates the next set of results that you want to
    /// retrieve.
    next_page_token: ?[]const u8 = null,

    /// The number of recommendations that you want returned in a single response
    /// object.
    page_size: ?i32 = null,

    /// The reservation purchase option that you want recommendations for.
    payment_option: ?PaymentOption = null,

    /// The specific service that you want recommendations for.
    service: []const u8,

    /// The hardware specifications for the service instances that you want
    /// recommendations
    /// for, such as standard or convertible Amazon EC2 instances.
    service_specification: ?ServiceSpecification = null,

    /// The reservation term that you want recommendations for.
    term_in_years: ?TermInYears = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_scope = "AccountScope",
        .filter = "Filter",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .next_page_token = "NextPageToken",
        .page_size = "PageSize",
        .payment_option = "PaymentOption",
        .service = "Service",
        .service_specification = "ServiceSpecification",
        .term_in_years = "TermInYears",
    };
};

pub const GetReservationPurchaseRecommendationOutput = struct {
    /// Information about this specific recommendation call, such as the time stamp
    /// for when
    /// Cost Explorer generated this recommendation.
    metadata: ?ReservationPurchaseRecommendationMetadata = null,

    /// The pagination token for the next set of retrievable results.
    next_page_token: ?[]const u8 = null,

    /// Recommendations for reservations to purchase.
    recommendations: ?[]const ReservationPurchaseRecommendation = null,

    pub const json_field_names = .{
        .metadata = "Metadata",
        .next_page_token = "NextPageToken",
        .recommendations = "Recommendations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReservationPurchaseRecommendationInput, options: CallOptions) !GetReservationPurchaseRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ce");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReservationPurchaseRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetReservationPurchaseRecommendation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReservationPurchaseRecommendationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetReservationPurchaseRecommendationOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AnalysisNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .analysis_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackfillLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .backfill_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BillExpirationException")) {
        return .{ .arena = arena, .kind = .{ .bill_expiration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BillingViewHealthStatusException")) {
        return .{ .arena = arena, .kind = .{ .billing_view_health_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DataUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .data_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GenerationExistsException")) {
        return .{ .arena = arena, .kind = .{ .generation_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "RequestChangedException")) {
        return .{ .arena = arena, .kind = .{ .request_changed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownMonitorException")) {
        return .{ .arena = arena, .kind = .{ .unknown_monitor_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownSubscriptionException")) {
        return .{ .arena = arena, .kind = .{ .unknown_subscription_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnresolvableUsageUnitException")) {
        return .{ .arena = arena, .kind = .{ .unresolvable_usage_unit_exception = .{
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
