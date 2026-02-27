/// The preferences and settings that will be used to compute the Amazon Web
/// Services charges for a billing group.
pub const ComputationPreference = struct {
    /// The Amazon Resource Name (ARN) of the pricing plan that's used to compute
    /// the Amazon Web Services charges for a billing group.
    pricing_plan_arn: []const u8,

    pub const json_field_names = .{
        .pricing_plan_arn = "PricingPlanArn",
    };
};
