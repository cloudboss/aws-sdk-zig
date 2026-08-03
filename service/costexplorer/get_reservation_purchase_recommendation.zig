const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetReservationPurchaseRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AnalysisNotFoundException = aws.json.parseJsonObject(errors.AnalysisNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .analysis_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackfillLimitExceededException")) {
        const parsed_error: ?errors.BackfillLimitExceededException = aws.json.parseJsonObject(errors.BackfillLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backfill_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BillExpirationException")) {
        const parsed_error: ?errors.BillExpirationException = aws.json.parseJsonObject(errors.BillExpirationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bill_expiration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BillingViewHealthStatusException")) {
        const parsed_error: ?errors.BillingViewHealthStatusException = aws.json.parseJsonObject(errors.BillingViewHealthStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .billing_view_health_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataUnavailableException")) {
        const parsed_error: ?errors.DataUnavailableException = aws.json.parseJsonObject(errors.DataUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GenerationExistsException")) {
        const parsed_error: ?errors.GenerationExistsException = aws.json.parseJsonObject(errors.GenerationExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .generation_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestChangedException")) {
        const parsed_error: ?errors.RequestChangedException = aws.json.parseJsonObject(errors.RequestChangedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_changed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownMonitorException")) {
        const parsed_error: ?errors.UnknownMonitorException = aws.json.parseJsonObject(errors.UnknownMonitorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_monitor_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownSubscriptionException")) {
        const parsed_error: ?errors.UnknownSubscriptionException = aws.json.parseJsonObject(errors.UnknownSubscriptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_subscription_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnresolvableUsageUnitException")) {
        const parsed_error: ?errors.UnresolvableUsageUnitException = aws.json.parseJsonObject(errors.UnresolvableUsageUnitException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unresolvable_usage_unit_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
