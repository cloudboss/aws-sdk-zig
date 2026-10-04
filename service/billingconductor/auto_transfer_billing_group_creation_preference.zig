/// The auto billing group creation preference for a billing transfer. When the
/// preference is enabled, Billing Conductor automatically creates an indirect
/// billing transfer billing group, with the specified pricing plan, for each
/// account that transfers its bill to the bill source account of the billing
/// transfer.
pub const AutoTransferBillingGroupCreationPreference = struct {
    /// Specifies whether Billing Conductor automatically creates billing groups for
    /// the billing transfer. The preference is disabled by default.
    enabled: bool,

    /// The Amazon Resource Name (ARN) of the pricing plan to apply to the
    /// automatically created billing groups. This value is required when `Enabled`
    /// is `true`, and must be omitted when `Enabled` is `false`.
    pricing_plan_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .pricing_plan_arn = "PricingPlanArn",
    };
};
