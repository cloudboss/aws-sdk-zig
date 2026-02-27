const PropertyLocation = @import("property_location.zig").PropertyLocation;
const ResponseExtractionMapping = @import("response_extraction_mapping.zig").ResponseExtractionMapping;

/// Parameter extraction configuration that defines how to extract and map
/// values from API responses to request parameters.
pub const ExtractedParameter = struct {
    /// The default value to use if the parameter cannot be extracted from the
    /// response.
    default_value: ?[]const u8,

    /// The parameter key name that will be used in subsequent requests.
    key: ?[]const u8,

    /// Specifies where this extracted parameter should be placed in subsequent
    /// requests, such as in headers, query parameters, or request body.
    property_location: ?PropertyLocation,

    /// The JSON path or extraction mapping that defines how to extract the
    /// parameter value from API responses.
    value: ?ResponseExtractionMapping,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .key = "Key",
        .property_location = "PropertyLocation",
        .value = "Value",
    };
};
