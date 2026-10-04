const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// The feature flag value configuration for a treatment, including the enabled
/// state and attribute values.
pub const FlagValue = struct {
    /// The attribute values associated with this flag value.
    attribute_values: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// Specifies whether the feature flag is enabled for this treatment.
    enabled: bool = false,

    pub const json_field_names = .{
        .attribute_values = "AttributeValues",
        .enabled = "Enabled",
    };
};
