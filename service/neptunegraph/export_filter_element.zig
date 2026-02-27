const aws = @import("aws");

const ExportFilterPropertyAttributes = @import("export_filter_property_attributes.zig").ExportFilterPropertyAttributes;

/// Specifies which properties of that label should be included in the export.
pub const ExportFilterElement = struct {
    /// Each property is defined by a key-value pair, where the key is the desired
    /// output property name (e.g. "name"), and the value is an object.
    properties: ?[]const aws.map.MapEntry(ExportFilterPropertyAttributes),

    pub const json_field_names = .{
        .properties = "properties",
    };
};
