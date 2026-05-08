const VariantConfiguration = @import("variant_configuration.zig").VariantConfiguration;

/// A variant in an A/B test, representing either the control (C) or treatment
/// (T1) configuration.
pub const Variant = struct {
    /// The name of the variant. Must be `C` for control or `T1` for treatment.
    name: []const u8,

    /// The configuration for this variant, including the configuration bundle or
    /// target reference.
    variant_configuration: VariantConfiguration,

    /// The percentage of traffic to route to this variant. Weights across all
    /// variants must sum to 100.
    weight: i32,

    pub const json_field_names = .{
        .name = "name",
        .variant_configuration = "variantConfiguration",
        .weight = "weight",
    };
};
