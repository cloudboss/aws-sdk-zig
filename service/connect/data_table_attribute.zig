const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const Validation = @import("validation.zig").Validation;
const DataTableAttributeValueType = @import("data_table_attribute_value_type.zig").DataTableAttributeValueType;

/// Represents an attribute (column) in a data table. Attributes define the
/// schema and validation rules for values
/// that can be stored in the table. They specify the data type, constraints,
/// and whether the attribute is used as a
/// primary key for record identification.
pub const DataTableAttribute = struct {
    /// The unique identifier for the attribute within the data table.
    attribute_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the data table that contains this
    /// attribute.
    data_table_arn: ?[]const u8 = null,

    /// The unique identifier of the data table that contains this attribute.
    data_table_id: ?[]const u8 = null,

    /// An optional description explaining the purpose and usage of this attribute.
    description: ?[]const u8 = null,

    /// The Amazon Web Services Region where this attribute was last modified, used
    /// for region replication.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this attribute was last modified.
    last_modified_time: ?i64 = null,

    /// The lock version for this attribute, used for optimistic locking to prevent
    /// concurrent modification
    /// conflicts.
    lock_version: ?DataTableLockVersion = null,

    /// The human-readable name of the attribute. Must be unique within the data
    /// table and conform to Connect naming
    /// standards.
    name: []const u8,

    /// Boolean indicating whether this attribute is used as a primary key for
    /// record identification. Primary attributes
    /// must have unique value combinations and cannot contain expressions.
    primary: bool = false,

    /// The validation rules applied to values of this attribute. Based on JSON
    /// Schema Draft 2020-12 with additional
    /// Connect-specific validations for data integrity.
    validation: ?Validation = null,

    /// The type of value allowed for this attribute. Must be one of TEXT,
    /// TEXT_LIST, NUMBER, NUMBER_LIST, or BOOLEAN.
    /// Determines how values are validated and processed.
    value_type: DataTableAttributeValueType,

    /// The version identifier for this attribute, used for versioning and change
    /// tracking.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_id = "AttributeId",
        .data_table_arn = "DataTableArn",
        .data_table_id = "DataTableId",
        .description = "Description",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .lock_version = "LockVersion",
        .name = "Name",
        .primary = "Primary",
        .validation = "Validation",
        .value_type = "ValueType",
        .version = "Version",
    };
};
