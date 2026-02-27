const SchemaColumn = @import("schema_column.zig").SchemaColumn;
const TransformStatusType = @import("transform_status_type.zig").TransformStatusType;
const TransformType = @import("transform_type.zig").TransformType;

/// The criteria used to filter the machine learning transforms.
pub const TransformFilterCriteria = struct {
    /// The time and date after which the transforms were created.
    created_after: ?i64,

    /// The time and date before which the transforms were created.
    created_before: ?i64,

    /// This value determines which version of Glue this machine learning transform
    /// is compatible with. Glue 1.0 is recommended for most customers. If the value
    /// is not set, the Glue compatibility defaults to Glue 0.9. For more
    /// information, see [Glue
    /// Versions](https://docs.aws.amazon.com/glue/latest/dg/release-notes.html#release-notes-versions) in the developer guide.
    glue_version: ?[]const u8,

    /// Filter on transforms last modified after this date.
    last_modified_after: ?i64,

    /// Filter on transforms last modified before this date.
    last_modified_before: ?i64,

    /// A unique transform name that is used to filter the machine learning
    /// transforms.
    name: ?[]const u8,

    /// Filters on datasets with a specific schema. The `Map`
    /// object is an array of key-value pairs representing the schema this transform
    /// accepts, where
    /// `Column` is the name of a column, and `Type` is the type of the data
    /// such as an integer or string. Has an upper bound of 100 columns.
    schema: ?[]const SchemaColumn,

    /// Filters the list of machine learning transforms by the last known status of
    /// the transforms (to indicate whether a transform can be used or not). One of
    /// "NOT_READY", "READY", or "DELETING".
    status: ?TransformStatusType,

    /// The type of machine learning transform that is used to filter the machine
    /// learning
    /// transforms.
    transform_type: ?TransformType,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .glue_version = "GlueVersion",
        .last_modified_after = "LastModifiedAfter",
        .last_modified_before = "LastModifiedBefore",
        .name = "Name",
        .schema = "Schema",
        .status = "Status",
        .transform_type = "TransformType",
    };
};
