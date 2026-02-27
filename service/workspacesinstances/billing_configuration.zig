const BillingMode = @import("billing_mode.zig").BillingMode;

/// Defines billing configuration settings for WorkSpace Instances, containing
/// the billing mode selection.
pub const BillingConfiguration = struct {
    /// Specifies the billing mode for WorkSpace Instances. MONTHLY provides fixed
    /// monthly rates for predictable budgeting, while HOURLY enables pay-per-second
    /// billing for actual usage.
    billing_mode: BillingMode,

    pub const json_field_names = .{
        .billing_mode = "BillingMode",
    };
};
