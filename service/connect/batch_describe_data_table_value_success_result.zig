const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const PrimaryValueResponse = @import("primary_value_response.zig").PrimaryValueResponse;

/// A batch describe data table value success result.
pub const BatchDescribeDataTableValueSuccessResult = struct {
    /// The result's attribute ID.
    attribute_id: []const u8,

    /// The result's attribute name.
    attribute_name: []const u8,

    /// The result's last modified region.
    last_modified_region: ?[]const u8 = null,

    /// The result's last modified time.
    last_modified_time: ?i64 = null,

    /// The result's lock version.
    lock_version: DataTableLockVersion,

    /// The result's primary values.
    primary_values: []const PrimaryValueResponse,

    /// The result's record ID.
    record_id: []const u8,

    /// The result's value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_id = "AttributeId",
        .attribute_name = "AttributeName",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .lock_version = "LockVersion",
        .primary_values = "PrimaryValues",
        .record_id = "RecordId",
        .value = "Value",
    };
};
