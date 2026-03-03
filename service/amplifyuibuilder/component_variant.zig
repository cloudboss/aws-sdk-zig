const aws = @import("aws");

/// Describes the style configuration of a unique variation of a main component.
pub const ComponentVariant = struct {
    /// The properties of the component variant that can be overriden when
    /// customizing an instance
    /// of the component. You can't specify `tags` as a valid property for
    /// `overrides`.
    overrides: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// The combination of variants that comprise this variant. You can't specify
    /// `tags` as a valid property for `variantValues`.
    variant_values: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .overrides = "overrides",
        .variant_values = "variantValues",
    };
};
