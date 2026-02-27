pub const ModelTypeEnum = enum {
    online_fraud_insights,
    transaction_fraud_insights,
    account_takeover_insights,

    pub const json_field_names = .{
        .online_fraud_insights = "ONLINE_FRAUD_INSIGHTS",
        .transaction_fraud_insights = "TRANSACTION_FRAUD_INSIGHTS",
        .account_takeover_insights = "ACCOUNT_TAKEOVER_INSIGHTS",
    };
};
