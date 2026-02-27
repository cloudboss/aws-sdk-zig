const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    page_size: i32 = 0,

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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSavingsPlansPurchaseRecommendationInput, options: Options) !GetSavingsPlansPurchaseRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "costexplorer");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetSavingsPlansPurchaseRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("costexplorer", "Cost Explorer", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSInsightsIndexService.GetSavingsPlansPurchaseRecommendation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetSavingsPlansPurchaseRecommendationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSavingsPlansPurchaseRecommendationOutput, body, alloc);
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
