const aws = @import("aws");

const ConfigurationBundleReference = @import("configuration_bundle_reference.zig").ConfigurationBundleReference;

/// An entry in a traffic split configuration, defining a named variant with a
/// weight and configuration bundle reference.
pub const TrafficSplitEntry = struct {
    /// The configuration bundle reference for this variant.
    configuration_bundle: ConfigurationBundleReference,

    /// The description of this traffic split variant.
    description: ?[]const u8 = null,

    /// Key-value metadata associated with this traffic split variant.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The name of this traffic split variant.
    name: []const u8,

    /// The percentage of traffic to route to this variant. Weights across all
    /// entries must sum to 100.
    weight: i32,

    pub const json_field_names = .{
        .configuration_bundle = "configurationBundle",
        .description = "description",
        .metadata = "metadata",
        .name = "name",
        .weight = "weight",
    };
};
