/// The current status of your Deliverability dashboard subscription. If this
/// value is
/// `PENDING_EXPIRATION`, your subscription is scheduled to expire at the end
/// of the current calendar month.
pub const DeliverabilityDashboardAccountStatus = enum {
    active,
    pending_expiration,
    disabled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending_expiration = "PENDING_EXPIRATION",
        .disabled = "DISABLED",
    };
};
