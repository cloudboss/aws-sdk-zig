/// A type of an action required from the customer.
pub const CustomerActionStatus = enum {
    critical_action_required,
    action_recommended,
    none,

    pub const json_field_names = .{
        .critical_action_required = "CRITICAL_ACTION_REQUIRED",
        .action_recommended = "ACTION_RECOMMENDED",
        .none = "NONE",
    };
};
