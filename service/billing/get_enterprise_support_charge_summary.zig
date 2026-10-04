const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const GetEnterpriseSupportChargeSummaryInput = struct {
    /// The billing month in YYYY-MM format. This must be a month in the past.
    billing_month: []const u8,

    pub const json_field_names = .{
        .billing_month = "billingMonth",
    };
};

pub const GetEnterpriseSupportChargeSummaryOutput = struct {
    /// The date the bill was generated.
    bill_date: i64,

    /// The billing month in YYYY-MM format. This must be a month in the past.
    billing_month: []const u8,

    /// The end date of the billing period.
    billing_period_end_date: i64,

    /// The start date of the billing period.
    billing_period_start_date: i64,

    /// Specifies whether the Support charge amount is estimated. When false, the
    /// charge amount is finalized.
    is_estimated: bool,

    /// The payer account ID that is authorized to view Enterprise Support data for
    /// all accounts in its Support profile.
    payer_account_id: []const u8,

    /// The Support charge amount for the account.
    support_charge: []const u8,

    /// The percentage applied to the total Support-eligible spend to calculate the
    /// total Support charge across all accounts in the Support profile.
    support_charge_percentage: []const u8,

    /// The support discount amount.
    support_discount: []const u8,

    /// The effective pricing plan used for the support charge calculation.
    support_effective_pricing_plan: ?PricingPlan = null,

    /// The total Support charge amount for all accounts in the Support profile.
    total_support_charge: []const u8,

    /// The total Support-eligible Reserved Instance spend from all accounts in the
    /// Support profile.
    total_support_eligible_reserved_instance_spend: []const u8,

    /// The total Support-eligible Savings Plan spend from all accounts in the
    /// Support profile.
    total_support_eligible_savings_plan_spend: []const u8,

    /// The total Support-eligible Spend from all accounts in the Support profile.
    /// This includes eligible spend from usage of Amazon Web Services, Reserved
    /// Instances, and Savings Plans.
    total_support_eligible_spend: []const u8,

    /// The total Support-eligible spend from usage of Amazon Web Services from all
    /// accounts in the Support profile.
    total_support_eligible_usage_spend: []const u8,

    pub const json_field_names = .{
        .bill_date = "billDate",
        .billing_month = "billingMonth",
        .billing_period_end_date = "billingPeriodEndDate",
        .billing_period_start_date = "billingPeriodStartDate",
        .is_estimated = "isEstimated",
        .payer_account_id = "payerAccountId",
        .support_charge = "supportCharge",
        .support_charge_percentage = "supportChargePercentage",
        .support_discount = "supportDiscount",
        .support_effective_pricing_plan = "supportEffectivePricingPlan",
        .total_support_charge = "totalSupportCharge",
        .total_support_eligible_reserved_instance_spend = "totalSupportEligibleReservedInstanceSpend",
        .total_support_eligible_savings_plan_spend = "totalSupportEligibleSavingsPlanSpend",
        .total_support_eligible_spend = "totalSupportEligibleSpend",
        .total_support_eligible_usage_spend = "totalSupportEligibleUsageSpend",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnterpriseSupportChargeSummaryInput, options: CallOptions) !GetEnterpriseSupportChargeSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billing", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnterpriseSupportChargeSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billing", "Billing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.GetEnterpriseSupportChargeSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnterpriseSupportChargeSummaryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetEnterpriseSupportChargeSummaryOutput, body, allocator);
}
