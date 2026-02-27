const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const PrimaryValue = @import("primary_value.zig").PrimaryValue;

/// A data table delete value identifier.
pub const DataTableDeleteValueIdentifier = struct {
    /// The identifier's attribute name.
    attribute_name: []const u8,

    /// The identifier's lock version.
    lock_version: DataTableLockVersion,

    /// The identifier's primary values.
    primary_values: ?[]const PrimaryValue,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .lock_version = "LockVersion",
        .primary_values = "PrimaryValues",
    };
};
