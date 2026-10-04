const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdditionalCharge = @import("additional_charge.zig").AdditionalCharge;
const ChargeAccount = @import("charge_account.zig").ChargeAccount;
const ContractAccount = @import("contract_account.zig").ContractAccount;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const GetEnterpriseSupportContractDetailsInput = struct {
    /// The billing month in YYYY-MM format. This must be a month in the past.
    billing_month: []const u8,

    pub const json_field_names = .{
        .billing_month = "billingMonth",
    };
};

pub const GetEnterpriseSupportContractDetailsOutput = struct {
    /// Any Additional support charges applied to the contract.
    additional_support_charge: ?[]const AdditionalCharge = null,

    /// Any Additional support-eligible usage spend charges.
    additional_support_eligible_usage_spend: ?[]const AdditionalCharge = null,

    /// The list of payer accounts and their charge allocation percentages.
    charged_payer_account_ids: ?[]const ChargeAccount = null,

    /// The list of accounts covered by the Enterprise Support contract.
    contract_payer_account_ids: ?[]const ContractAccount = null,

    /// When true, the Enterprise Support contract is active. When false, the
    /// Enterprise Support Contract is inactive.
    is_contract_active: ?bool = null,

    /// The pricing plans associated with this Enterprise Support contract.
    pricing_plans: ?[]const PricingPlan = null,

    /// The method used to distribute the total Support charge amount across each
    /// account in the Support profile. Valid values: Proportional,
    /// Fixed_Percentage. Proportional means support charges are distributed to each
    /// account in proportion to its eligible Spend. Fixed_Percentage means support
    /// charges are distributed across accounts according to pre-configured
    /// percentages from the contract.
    support_allocation_method: []const u8,

    /// The start date for accounts subscribed or unsubscribed to Support billing
    /// during the billing month.
    support_prorate_start_date: ?i64 = null,

    /// When supportReservedInstanceTreatmentMethod = AmortizedCustom, only
    /// amortized fees for Reserved Instances purchased on or after this date are
    /// included in the calculation. This field is Null for all other treatment
    /// methods.
    support_reserved_instance_amortization_start_date: ?i64 = null,

    /// The method used to include Reserved Instance (RI) fees in the Enterprise
    /// Support charge calculation. Valid values: None (RI fees excluded from
    /// Support-eligible spend), Upfront (full upfront RI fees included in month of
    /// purchase), Amortized (RI fees spread over commitment term for RIs purchased
    /// on or after Support subscription start date), AmortizedCustom (same as
    /// Amortized but only for RIs purchased on or after a specified custom start
    /// date), AmortizedAll (RI fees amortized for all active RIs including those
    /// purchased before Support subscription started).
    support_reserved_instance_treatment_method: ?[]const u8 = null,

    /// This is applicable when supportSavingsPlansTreatmentMethod = Amortized and
    /// is Null for all other methods. It shows the start date from which Savings
    /// Plan fees are included in Support Eligible Spend.
    support_savings_plans_amortization_start_date: ?i64 = null,

    /// The method used to include Savings Plans fees in Enterprise Support charge
    /// calculations. Valid values: None (Savings Plan fees excluded from
    /// Support-eligible spend), Upfront (full upfront Savings Plan fees included in
    /// month of purchase), Amortized (Savings Plan fees spread over commitment term
    /// for Savings Plans purchased on or after Support subscription start date),
    /// AmortizedCustom (same as Amortized but only for Savings Plans purchased on
    /// or after a specified custom start date), AmortizedAll (Savings Plan fees
    /// amortized for all active Savings Plans including those purchased before
    /// Support subscription started).
    support_savings_plans_treatment_method: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_support_charge = "additionalSupportCharge",
        .additional_support_eligible_usage_spend = "additionalSupportEligibleUsageSpend",
        .charged_payer_account_ids = "chargedPayerAccountIds",
        .contract_payer_account_ids = "contractPayerAccountIds",
        .is_contract_active = "isContractActive",
        .pricing_plans = "pricingPlans",
        .support_allocation_method = "supportAllocationMethod",
        .support_prorate_start_date = "supportProrateStartDate",
        .support_reserved_instance_amortization_start_date = "supportReservedInstanceAmortizationStartDate",
        .support_reserved_instance_treatment_method = "supportReservedInstanceTreatmentMethod",
        .support_savings_plans_amortization_start_date = "supportSavingsPlansAmortizationStartDate",
        .support_savings_plans_treatment_method = "supportSavingsPlansTreatmentMethod",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnterpriseSupportContractDetailsInput, options: CallOptions) !GetEnterpriseSupportContractDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnterpriseSupportContractDetailsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.GetEnterpriseSupportContractDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnterpriseSupportContractDetailsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetEnterpriseSupportContractDetailsOutput, body, allocator);
}
