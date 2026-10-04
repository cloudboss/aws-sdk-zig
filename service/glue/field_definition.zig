const FieldDataType = @import("field_data_type.zig").FieldDataType;
const FilterOverrides = @import("filter_overrides.zig").FilterOverrides;

/// Defines a field in an entity schema for REST connector data sources,
/// specifying the field name and data type.
pub const FieldDefinition = struct {
    /// The data type of the field.
    field_data_type: FieldDataType,

    /// Per-field overrides for filter behavior, allowing customization of how
    /// filters are applied to this specific field.
    filter_overrides: ?FilterOverrides = null,

    /// Indicates whether this field can contain null values.
    is_nullable: ?bool = null,

    /// Indicates whether this field can be used for ordering results.
    is_orderable: ?bool = null,

    /// Indicates whether this field can be used for partitioning queries to the
    /// data source.
    is_partitionable: ?bool = null,

    /// Indicates whether this field can be used in filter predicates when querying
    /// data.
    is_queryable: ?bool = null,

    /// The name of the field in the entity schema.
    name: []const u8,

    /// The format pattern for parsing date values from API responses. Required when
    /// the API uses a non-ISO-8601 format. Accepts Java `DateTimeFormatter`
    /// patterns (for example, `EEE, d MMM yyyy HH:mm:ss Z`), `EPOCH_SECONDS` for
    /// Unix epoch seconds, or `EPOCH_MILLIS` for Unix epoch milliseconds.
    response_date_format: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_data_type = "FieldDataType",
        .filter_overrides = "FilterOverrides",
        .is_nullable = "IsNullable",
        .is_orderable = "IsOrderable",
        .is_partitionable = "IsPartitionable",
        .is_queryable = "IsQueryable",
        .name = "Name",
        .response_date_format = "ResponseDateFormat",
    };
};
