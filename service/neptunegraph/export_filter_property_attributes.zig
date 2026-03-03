const MultiValueHandlingType = @import("multi_value_handling_type.zig").MultiValueHandlingType;

/// A structure representing a property's attributes. It is a map object of
/// outputType, sourcePropertyName and multiValueHandling.
pub const ExportFilterPropertyAttributes = struct {
    /// Specifies how to handle properties that have multiple values. Can be either
    /// `TO_LIST` to export all values as a list, or `PICK_FIRST` to export the
    /// first value encountered. If not specified, the default value is
    /// `PICK_FIRST`.
    multi_value_handling: MultiValueHandlingType = "PICK_FIRST",

    /// Specifies the data type to use for the property in the exported data (e.g.
    /// "String", "Int", "Float"). If a type is not provided, the export process
    /// will determine the type. If a given property is present as multiple types
    /// (e.g. one vertex has "height" stored as a double, and another edge has it
    /// stored as a string), the type will be of Any type, otherwise, it will be the
    /// type of the property as present in vertices.
    output_type: ?[]const u8 = null,

    /// The name of the property as it exists in the original graph data. If not
    /// provided, it is assumed that the key matches the desired sourcePropertyName.
    source_property_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .multi_value_handling = "multiValueHandling",
        .output_type = "outputType",
        .source_property_name = "sourcePropertyName",
    };
};
