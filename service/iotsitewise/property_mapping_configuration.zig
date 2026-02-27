const PropertyMapping = @import("property_mapping.zig").PropertyMapping;

/// Contains configuration options for mapping properties from an interface
/// asset model to an
/// asset model where the interface is applied.
pub const PropertyMappingConfiguration = struct {
    /// If true, missing properties from the interface asset model are automatically
    /// created in
    /// the asset model where the interface is applied.
    create_missing_property: bool = false,

    /// If true, properties are matched by name between the interface asset model
    /// and the asset
    /// model where the interface is applied.
    match_by_property_name: bool = false,

    /// A list of specific property mappings that override the automatic mapping by
    /// name when an
    /// interface is applied to an asset model.
    overrides: ?[]const PropertyMapping,

    pub const json_field_names = .{
        .create_missing_property = "createMissingProperty",
        .match_by_property_name = "matchByPropertyName",
        .overrides = "overrides",
    };
};
