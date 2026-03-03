const ValidAdditionalStorageOptions = @import("valid_additional_storage_options.zig").ValidAdditionalStorageOptions;
const ValidStorageOptions = @import("valid_storage_options.zig").ValidStorageOptions;
const AvailableProcessorFeature = @import("available_processor_feature.zig").AvailableProcessorFeature;

/// Information about valid modifications that you can make to your DB instance.
/// Contains the result of a successful call to the
/// `DescribeValidDBInstanceModifications` action. You can use this information
/// when you call `ModifyDBInstance`.
pub const ValidDBInstanceModificationsMessage = struct {
    /// The valid additional storage options for the DB instance.
    additional_storage: ?ValidAdditionalStorageOptions = null,

    /// Valid storage options for your DB instance.
    storage: ?[]const ValidStorageOptions = null,

    /// Indicates whether a DB instance supports using a dedicated log volume (DLV).
    supports_dedicated_log_volume: ?bool = null,

    /// Valid processor features for your DB instance.
    valid_processor_features: ?[]const AvailableProcessorFeature = null,
};
