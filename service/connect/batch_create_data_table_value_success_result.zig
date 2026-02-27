const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const PrimaryValue = @import("primary_value.zig").PrimaryValue;

/// A batch create data table value success result.
pub const BatchCreateDataTableValueSuccessResult = struct {
    /// The result's attribute name.
    attribute_name: []const u8,

    /// The result's lock version.
    lock_version: DataTableLockVersion,

    /// The result's primary values.
    primary_values: []const PrimaryValue,

    /// The result's record ID.
    record_id: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .lock_version = "LockVersion",
        .primary_values = "PrimaryValues",
        .record_id = "RecordId",
    };
};
