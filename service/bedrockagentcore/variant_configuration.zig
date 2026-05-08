const ConfigurationBundleRef = @import("configuration_bundle_ref.zig").ConfigurationBundleRef;
const TargetRef = @import("target_ref.zig").TargetRef;

/// The configuration for an A/B test variant.
pub const VariantConfiguration = struct {
    /// A reference to a configuration bundle version to use for this variant.
    configuration_bundle: ?ConfigurationBundleRef = null,

    /// A reference to a gateway target to route traffic to for this variant.
    target: ?TargetRef = null,

    pub const json_field_names = .{
        .configuration_bundle = "configurationBundle",
        .target = "target",
    };
};
