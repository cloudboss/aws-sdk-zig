const EnterpriseSupportTimePeriod = @import("enterprise_support_time_period.zig").EnterpriseSupportTimePeriod;
const ServiceLevelAccountUsage = @import("service_level_account_usage.zig").ServiceLevelAccountUsage;

/// Enterprise Support charges for a linked account.
pub const LinkedAccountCharge = struct {
    /// The linked account ID.
    account_id: []const u8,

    /// The type of account.
    account_type: ?[]const u8 = null,

    /// The number of billable seconds in the billing period based on when the
    /// account was subscribed to Enterprise Support.
    billable_seconds: i64,

    /// The time periods during which this account was linked.
    linked_time_periods: ?[]const EnterpriseSupportTimePeriod = null,

    /// The payer account ID that is authorized to view Enterprise Support data for
    /// all accounts in its Support profile.
    payer_account_id: []const u8,

    /// The prorated total support-eligible spend based on when the account was
    /// subscribed to Enterprise Support.
    prorated_total_support_eligible_spend: []const u8,

    /// The subscription time periods for this account.
    subscription_time_periods: ?[]const EnterpriseSupportTimePeriod = null,

    /// The support-eligible spend broken down by service.
    support_eligible_spend_by_service: ?[]const ServiceLevelAccountUsage = null,

    /// The total number of seconds in the billing period.
    total_seconds: i64,

    /// The total support-eligible Reserved Instance spend for this account.
    total_support_eligible_reserved_instance_spend: ?[]const u8 = null,

    /// The total support-eligible Savings Plan spend for this account.
    total_support_eligible_savings_plan_spend: ?[]const u8 = null,

    /// The total support-eligible spend for this account.
    total_support_eligible_spend: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_type = "accountType",
        .billable_seconds = "billableSeconds",
        .linked_time_periods = "linkedTimePeriods",
        .payer_account_id = "payerAccountId",
        .prorated_total_support_eligible_spend = "proratedTotalSupportEligibleSpend",
        .subscription_time_periods = "subscriptionTimePeriods",
        .support_eligible_spend_by_service = "supportEligibleSpendByService",
        .total_seconds = "totalSeconds",
        .total_support_eligible_reserved_instance_spend = "totalSupportEligibleReservedInstanceSpend",
        .total_support_eligible_savings_plan_spend = "totalSupportEligibleSavingsPlanSpend",
        .total_support_eligible_spend = "totalSupportEligibleSpend",
    };
};
