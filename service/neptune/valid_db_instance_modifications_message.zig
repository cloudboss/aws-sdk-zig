const ValidStorageOptions = @import("valid_storage_options.zig").ValidStorageOptions;

/// Information about valid modifications that you can make to your DB instance.
/// Contains the
/// result of a successful call to the DescribeValidDBInstanceModifications
/// action. You can use this information when you call ModifyDBInstance.
pub const ValidDBInstanceModificationsMessage = struct {
    /// Valid storage options for your DB instance.
    storage: ?[]const ValidStorageOptions,
};
