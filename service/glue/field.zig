const aws = @import("aws");

const FieldDataType = @import("field_data_type.zig").FieldDataType;
const FieldFilterOperator = @import("field_filter_operator.zig").FieldFilterOperator;

/// The `Field` object has information about the different properties associated
/// with a field in the connector.
pub const Field = struct {
    /// Optional map of keys which may be returned.
    custom_properties: ?[]const aws.map.StringMapEntry = null,

    /// A description of the field.
    description: ?[]const u8 = null,

    /// A unique identifier for the field.
    field_name: ?[]const u8 = null,

    /// The type of data in the field.
    field_type: ?FieldDataType = null,

    /// Indicates whether this field can be created as part of a destination write.
    is_createable: ?bool = null,

    /// Indicates whether this field is populated automatically when the object is
    /// created, such as a created at timestamp.
    is_default_on_create: ?bool = null,

    /// Indicates whether this field can used in a filter clause (`WHERE` clause) of
    /// a SQL statement when querying data.
    is_filterable: ?bool = null,

    /// Indicates whether this field can be nullable or not.
    is_nullable: ?bool = null,

    /// Indicates whether a given field can be used in partitioning the query made
    /// to SaaS.
    is_partitionable: ?bool = null,

    /// Indicates whether this field can used as a primary key for the given entity.
    is_primary_key: ?bool = null,

    /// Indicates whether this field can be added in Select clause of SQL query or
    /// whether it is retrievable or not.
    is_retrievable: ?bool = null,

    /// Indicates whether this field can be updated as part of a destination write.
    is_updateable: ?bool = null,

    /// Indicates whether this field can be upserted as part of a destination write.
    is_upsertable: ?bool = null,

    /// A readable label used for the field.
    label: ?[]const u8 = null,

    /// The data type returned by the SaaS API, such as “picklist” or “textarea”
    /// from Salesforce.
    native_data_type: ?[]const u8 = null,

    /// A parent field name for a nested field.
    parent_field: ?[]const u8 = null,

    /// Indicates the support filter operators for this field.
    supported_filter_operators: ?[]const FieldFilterOperator = null,

    /// A list of supported values for the field.
    supported_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .custom_properties = "CustomProperties",
        .description = "Description",
        .field_name = "FieldName",
        .field_type = "FieldType",
        .is_createable = "IsCreateable",
        .is_default_on_create = "IsDefaultOnCreate",
        .is_filterable = "IsFilterable",
        .is_nullable = "IsNullable",
        .is_partitionable = "IsPartitionable",
        .is_primary_key = "IsPrimaryKey",
        .is_retrievable = "IsRetrievable",
        .is_updateable = "IsUpdateable",
        .is_upsertable = "IsUpsertable",
        .label = "Label",
        .native_data_type = "NativeDataType",
        .parent_field = "ParentField",
        .supported_filter_operators = "SupportedFilterOperators",
        .supported_values = "SupportedValues",
    };
};
