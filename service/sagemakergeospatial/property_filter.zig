const Property = @import("property.zig").Property;

/// The structure representing a single PropertyFilter.
pub const PropertyFilter = struct {
    /// Represents a single property to match with when searching a raster data
    /// collection.
    property: Property,

    pub const json_field_names = .{
        .property = "Property",
    };
};
