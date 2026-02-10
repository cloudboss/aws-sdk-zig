const InventoryConfigurationState = @import("inventory_configuration_state.zig").InventoryConfigurationState;
const ErrorDetails = @import("error_details.zig").ErrorDetails;

/// The inventory table configuration for an S3 Metadata configuration.
pub const InventoryTableConfigurationResult = struct {
    /// The configuration state of the inventory table, indicating whether the
    /// inventory table is enabled
    /// or disabled.
    configuration_state: InventoryConfigurationState,

    @"error": ?ErrorDetails,

    /// The Amazon Resource Name (ARN) for the inventory table.
    table_arn: ?[]const u8,

    /// The name of the inventory table.
    table_name: ?[]const u8,

    /// The status of the inventory table. The status values are:
    ///
    /// * `CREATING` - The inventory table is in the process of being created in the
    ///   specified
    /// Amazon Web Services managed table bucket.
    ///
    /// * `BACKFILLING` - The inventory table is in the process of being backfilled.
    ///   When
    /// you enable the inventory table for your metadata configuration, the table
    /// goes through a
    /// process known as backfilling, during which Amazon S3 scans your general
    /// purpose bucket to retrieve
    /// the initial metadata for all objects in the bucket. Depending on the number
    /// of objects in your
    /// bucket, this process can take several hours. When the backfilling process is
    /// finished, the
    /// status of your inventory table changes from `BACKFILLING` to `ACTIVE`.
    /// After backfilling is completed, updates to your objects are reflected in the
    /// inventory table
    /// within one hour.
    ///
    /// * `ACTIVE` - The inventory table has been created successfully, and records
    ///   are being
    /// delivered to the table.
    ///
    /// * `FAILED` - Amazon S3 is unable to create the inventory table, or Amazon S3
    ///   is unable to deliver
    /// records.
    table_status: ?[]const u8,
};
