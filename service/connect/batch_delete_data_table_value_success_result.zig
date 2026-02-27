const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const PrimaryValue = @import("primary_value.zig").PrimaryValue;

/// A batch delete data table value success result.
pub const BatchDeleteDataTableValueSuccessResult = struct {
    /// The result's attribute name.
    attribute_name: []const u8,

    /// The result's lock version.
    lock_version: DataTableLockVersion,

    /// The result's primary values.
    primary_values: []const PrimaryValue,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .lock_version = "LockVersion",
        .primary_values = "PrimaryValues",
    };
};
