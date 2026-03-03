const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const PrimaryValueResponse = @import("primary_value_response.zig").PrimaryValueResponse;
const DataTableAttributeValueType = @import("data_table_attribute_value_type.zig").DataTableAttributeValueType;

/// A data table value summary.
pub const DataTableValueSummary = struct {
    /// The summary's attribute ID.
    attribute_id: ?[]const u8 = null,

    /// The summary's attribute name.
    attribute_name: []const u8,

    /// The summary's last modified region.
    last_modified_region: ?[]const u8 = null,

    /// The summary's last modified time.
    last_modified_time: ?i64 = null,

    /// The summary's lock version.
    lock_version: ?DataTableLockVersion = null,

    /// The summary's primary values.
    primary_values: []const PrimaryValueResponse,

    /// The summary's record ID.
    record_id: ?[]const u8 = null,

    /// The summary's value.
    value: []const u8,

    /// The summary's value type.
    value_type: DataTableAttributeValueType,

    pub const json_field_names = .{
        .attribute_id = "AttributeId",
        .attribute_name = "AttributeName",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .lock_version = "LockVersion",
        .primary_values = "PrimaryValues",
        .record_id = "RecordId",
        .value = "Value",
        .value_type = "ValueType",
    };
};
