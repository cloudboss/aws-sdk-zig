const InventoryDestination = @import("inventory_destination.zig").InventoryDestination;
const InventoryFilter = @import("inventory_filter.zig").InventoryFilter;
const InventoryIncludedObjectVersions = @import("inventory_included_object_versions.zig").InventoryIncludedObjectVersions;
const InventoryOptionalField = @import("inventory_optional_field.zig").InventoryOptionalField;
const InventorySchedule = @import("inventory_schedule.zig").InventorySchedule;

/// Specifies the S3 Inventory configuration for an Amazon S3 bucket. For more
/// information, see [GET Bucket
/// inventory](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETInventoryConfig.html) in the *Amazon S3 API Reference*.
pub const InventoryConfiguration = struct {
    /// Contains information about where to publish the inventory results.
    destination: InventoryDestination,

    /// Specifies an inventory filter. The inventory only includes objects that meet
    /// the filter's
    /// criteria.
    filter: ?InventoryFilter,

    /// The ID used to identify the inventory configuration.
    id: []const u8,

    /// Object versions to include in the inventory list. If set to `All`, the list
    /// includes all
    /// the object versions, which adds the version-related fields `VersionId`,
    /// `IsLatest`, and `DeleteMarker` to the list. If set to `Current`, the
    /// list does not contain these version-related fields.
    included_object_versions: InventoryIncludedObjectVersions,

    /// Specifies whether the inventory is enabled or disabled. If set to `True`, an
    /// inventory
    /// list is generated. If set to `False`, no inventory list is generated.
    is_enabled: bool,

    /// Contains the optional fields that are included in the inventory results.
    optional_fields: ?[]const InventoryOptionalField,

    /// Specifies the schedule for generating inventory results.
    schedule: InventorySchedule,
};
