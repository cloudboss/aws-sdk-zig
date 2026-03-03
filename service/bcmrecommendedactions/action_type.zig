const std = @import("std");

pub const ActionType = enum {
    add_alternate_billing_contact,
    create_anomaly_monitor,
    create_budget,
    enable_cost_optimization_hub,
    migrate_to_granular_permissions,
    payments_due,
    payments_past_due,
    review_anomalies,
    review_budget_alerts,
    review_budgets_exceeded,
    review_expiring_ri,
    review_expiring_sp,
    review_freetier_usage_alerts,
    review_freetier_credits_remaining,
    review_freetier_days_remaining,
    review_savings_opportunity_recommendations,
    update_expired_payment_method,
    update_invalid_payment_method,
    update_tax_exemption_certificate,
    update_tax_registration_number,

    pub const json_field_names = .{
        .add_alternate_billing_contact = "ADD_ALTERNATE_BILLING_CONTACT",
        .create_anomaly_monitor = "CREATE_ANOMALY_MONITOR",
        .create_budget = "CREATE_BUDGET",
        .enable_cost_optimization_hub = "ENABLE_COST_OPTIMIZATION_HUB",
        .migrate_to_granular_permissions = "MIGRATE_TO_GRANULAR_PERMISSIONS",
        .payments_due = "PAYMENTS_DUE",
        .payments_past_due = "PAYMENTS_PAST_DUE",
        .review_anomalies = "REVIEW_ANOMALIES",
        .review_budget_alerts = "REVIEW_BUDGET_ALERTS",
        .review_budgets_exceeded = "REVIEW_BUDGETS_EXCEEDED",
        .review_expiring_ri = "REVIEW_EXPIRING_RI",
        .review_expiring_sp = "REVIEW_EXPIRING_SP",
        .review_freetier_usage_alerts = "REVIEW_FREETIER_USAGE_ALERTS",
        .review_freetier_credits_remaining = "REVIEW_FREETIER_CREDITS_REMAINING",
        .review_freetier_days_remaining = "REVIEW_FREETIER_DAYS_REMAINING",
        .review_savings_opportunity_recommendations = "REVIEW_SAVINGS_OPPORTUNITY_RECOMMENDATIONS",
        .update_expired_payment_method = "UPDATE_EXPIRED_PAYMENT_METHOD",
        .update_invalid_payment_method = "UPDATE_INVALID_PAYMENT_METHOD",
        .update_tax_exemption_certificate = "UPDATE_TAX_EXEMPTION_CERTIFICATE",
        .update_tax_registration_number = "UPDATE_TAX_REGISTRATION_NUMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add_alternate_billing_contact => "ADD_ALTERNATE_BILLING_CONTACT",
            .create_anomaly_monitor => "CREATE_ANOMALY_MONITOR",
            .create_budget => "CREATE_BUDGET",
            .enable_cost_optimization_hub => "ENABLE_COST_OPTIMIZATION_HUB",
            .migrate_to_granular_permissions => "MIGRATE_TO_GRANULAR_PERMISSIONS",
            .payments_due => "PAYMENTS_DUE",
            .payments_past_due => "PAYMENTS_PAST_DUE",
            .review_anomalies => "REVIEW_ANOMALIES",
            .review_budget_alerts => "REVIEW_BUDGET_ALERTS",
            .review_budgets_exceeded => "REVIEW_BUDGETS_EXCEEDED",
            .review_expiring_ri => "REVIEW_EXPIRING_RI",
            .review_expiring_sp => "REVIEW_EXPIRING_SP",
            .review_freetier_usage_alerts => "REVIEW_FREETIER_USAGE_ALERTS",
            .review_freetier_credits_remaining => "REVIEW_FREETIER_CREDITS_REMAINING",
            .review_freetier_days_remaining => "REVIEW_FREETIER_DAYS_REMAINING",
            .review_savings_opportunity_recommendations => "REVIEW_SAVINGS_OPPORTUNITY_RECOMMENDATIONS",
            .update_expired_payment_method => "UPDATE_EXPIRED_PAYMENT_METHOD",
            .update_invalid_payment_method => "UPDATE_INVALID_PAYMENT_METHOD",
            .update_tax_exemption_certificate => "UPDATE_TAX_EXEMPTION_CERTIFICATE",
            .update_tax_registration_number => "UPDATE_TAX_REGISTRATION_NUMBER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
