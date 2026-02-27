const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const PrimaryValue = @import("primary_value.zig").PrimaryValue;

/// A data table value.
pub const DataTableValue = struct {
    /// The value's attribute name.
    attribute_name: []const u8,

    /// The value's last modified region.
    last_modified_region: ?[]const u8,

    /// The value's last modified time.
    last_modified_time: ?i64,

    /// The value's lock version.
    lock_version: ?DataTableLockVersion,

    /// The value's primary values.
    primary_values: ?[]const PrimaryValue,

    /// The value's value.
    value: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .lock_version = "LockVersion",
        .primary_values = "PrimaryValues",
        .value = "Value",
    };
};
