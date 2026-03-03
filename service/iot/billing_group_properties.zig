/// The properties of a billing group.
pub const BillingGroupProperties = struct {
    /// The description of the billing group.
    billing_group_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_group_description = "billingGroupDescription",
    };
};
