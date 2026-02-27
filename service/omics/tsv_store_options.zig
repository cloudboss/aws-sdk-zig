const aws = @import("aws");

const AnnotationType = @import("annotation_type.zig").AnnotationType;
const SchemaValueType = @import("schema_value_type.zig").SchemaValueType;

/// File settings for a TSV store.
pub const TsvStoreOptions = struct {
    /// The store's annotation type.
    annotation_type: ?AnnotationType,

    /// The store's header key to column name mapping.
    format_to_header: ?[]const aws.map.StringMapEntry,

    /// The store's schema.
    schema: ?[]const []const aws.map.MapEntry(SchemaValueType),

    pub const json_field_names = .{
        .annotation_type = "annotationType",
        .format_to_header = "formatToHeader",
        .schema = "schema",
    };
};
