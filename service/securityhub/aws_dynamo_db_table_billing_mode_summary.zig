/// Provides information about the billing for read/write capacity on the table.
pub const AwsDynamoDbTableBillingModeSummary = struct {
    /// The method used to charge for read and write throughput and to manage
    /// capacity.
    billing_mode: ?[]const u8,

    /// If the billing mode is `PAY_PER_REQUEST`, indicates when the billing mode
    /// was
    /// set to that value.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_update_to_pay_per_request_date_time: ?[]const u8,

    pub const json_field_names = .{
        .billing_mode = "BillingMode",
        .last_update_to_pay_per_request_date_time = "LastUpdateToPayPerRequestDateTime",
    };
};
