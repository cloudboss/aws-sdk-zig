const aws = @import("aws");

const AnnotationType = @import("annotation_type.zig").AnnotationType;
const SchemaValueType = @import("schema_value_type.zig").SchemaValueType;

/// The options for a TSV file.
pub const TsvVersionOptions = struct {
    /// The store version's annotation type.
    annotation_type: ?AnnotationType = null,

    /// The annotation store version's header key to column name mapping.
    format_to_header: ?[]const aws.map.StringMapEntry = null,

    /// The TSV schema for an annotation store version.
    schema: ?[]const []const aws.map.MapEntry(SchemaValueType) = null,

    pub const json_field_names = .{
        .annotation_type = "annotationType",
        .format_to_header = "formatToHeader",
        .schema = "schema",
    };
};
