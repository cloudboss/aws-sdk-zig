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
const SupportedSavingsPlansType = @import("supported_savings_plans_type.zig").SupportedSavingsPlansType;
const TermInYears = @import("term_in_years.zig").TermInYears;
const SavingsPlansPurchaseRecommendationMetadata = @import("savings_plans_purchase_recommendation_metadata.zig").SavingsPlansPurchaseRecommendationMetadata;
const SavingsPlansPurchaseRecommendation = @import("savings_plans_purchase_recommendation.zig").SavingsPlansPurchaseRecommendation;

pub const GetSavingsPlansPurchaseRecommendationInput = struct {
    /// The account scope that you want your recommendations for. Amazon Web
    /// Services calculates
    /// recommendations including the management account and member accounts if the
    /// value is set to
    /// `PAYER`. If the value is `LINKED`, recommendations are calculated for
    /// individual member accounts only.
    account_scope: ?AccountScope = null,

    /// You can filter your recommendations by Account ID with the `LINKED_ACCOUNT`
    /// dimension. To filter your recommendations by Account ID, specify `Key` as
    /// `LINKED_ACCOUNT` and `Value` as the comma-separated Acount ID(s) that
    /// you want to see Savings Plans purchase recommendations for.
    ///
    /// For GetSavingsPlansPurchaseRecommendation, the `Filter` doesn't include
    /// `CostCategories` or `Tags`. It only includes `Dimensions`.
    /// With `Dimensions`, `Key` must be `LINKED_ACCOUNT` and
    /// `Value` can be a single Account ID or multiple comma-separated Account IDs
    /// that
    /// you want to see Savings Plans Purchase Recommendations for. `AND` and
    /// `OR` operators are not supported.
    filter: ?Expression = null,

    /// The lookback period that's used to generate the recommendation.
    lookback_period_in_days: LookbackPeriodInDays,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_page_token: ?[]const u8 = null,

    /// The number of recommendations that you want returned in a single response
    /// object.
    page_size: ?i32 = null,

    /// The payment option that's used to generate these recommendations.
    payment_option: PaymentOption,

    /// The Savings Plans recommendation type that's requested.
    savings_plans_type: SupportedSavingsPlansType,

    /// The savings plan recommendation term that's used to generate these
    /// recommendations.
    term_in_years: TermInYears,

    pub const json_field_names = .{
        .account_scope = "AccountScope",
        .filter = "Filter",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .next_page_token = "NextPageToken",
        .page_size = "PageSize",
        .payment_option = "PaymentOption",
        .savings_plans_type = "SavingsPlansType",
        .term_in_years = "TermInYears",
    };
};

pub const GetSavingsPlansPurchaseRecommendationOutput = struct {
    /// Information that regards this specific recommendation set.
    metadata: ?SavingsPlansPurchaseRecommendationMetadata = null,

    /// The token for the next set of retrievable results. Amazon Web Services
    /// provides the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// Contains your request parameters, Savings Plan Recommendations Summary, and
    /// Details.
    savings_plans_purchase_recommendation: ?SavingsPlansPurchaseRecommendation = null,

    pub const json_field_names = .{
        .metadata = "Metadata",
        .next_page_token = "NextPageToken",
        .savings_plans_purchase_recommendation = "SavingsPlansPurchaseRecommendation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSavingsPlansPurchaseRecommendationInput, options: CallOptions) !GetSavingsPlansPurchaseRecommendationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSavingsPlansPurchaseRecommendationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetSavingsPlansPurchaseRecommendation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSavingsPlansPurchaseRecommendationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSavingsPlansPurchaseRecommendationOutput, body, allocator);
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
