const BillingMode = @import("billing_mode.zig").BillingMode;

/// Contains the details for the read/write capacity mode. This page talks about
/// `PROVISIONED` and `PAY_PER_REQUEST` billing modes. For more
/// information about these modes, see [Read/write capacity
/// mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadWriteCapacityMode.html).
///
/// You may need to switch to on-demand mode at least once in order to return a
/// `BillingModeSummary` response.
pub const BillingModeSummary = struct {
    /// Controls how you are charged for read and write throughput and how you
    /// manage
    /// capacity. This setting can be changed later.
    ///
    /// * `PROVISIONED` - Sets the read/write capacity mode to
    /// `PROVISIONED`. We recommend using `PROVISIONED` for
    /// predictable workloads.
    ///
    /// * `PAY_PER_REQUEST` - Sets the read/write capacity mode to
    /// `PAY_PER_REQUEST`. We recommend using
    /// `PAY_PER_REQUEST` for unpredictable workloads.
    billing_mode: ?BillingMode = null,

    /// Represents the time when `PAY_PER_REQUEST` was last set as the read/write
    /// capacity mode.
    last_update_to_pay_per_request_date_time: ?i64 = null,

    pub const json_field_names = .{
        .billing_mode = "BillingMode",
        .last_update_to_pay_per_request_date_time = "LastUpdateToPayPerRequestDateTime",
    };
};
