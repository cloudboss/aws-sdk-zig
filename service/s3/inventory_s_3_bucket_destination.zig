const InventoryEncryption = @import("inventory_encryption.zig").InventoryEncryption;
const InventoryFormat = @import("inventory_format.zig").InventoryFormat;

/// Contains the bucket name, file format, bucket owner (optional), and prefix
/// (optional) where
/// S3 Inventory results are published.
pub const InventoryS3BucketDestination = struct {
    /// The account ID that owns the destination S3 bucket. If no account ID is
    /// provided, the owner is not
    /// validated before exporting data.
    ///
    /// **Note:**
    ///
    /// Although this value is optional, we strongly recommend that you set it to
    /// help prevent problems
    /// if the destination bucket ownership changes.
    account_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the bucket where inventory results will be
    /// published.
    bucket: []const u8,

    /// Contains the type of server-side encryption used to encrypt the inventory
    /// results.
    encryption: ?InventoryEncryption,

    /// Specifies the output format of the inventory results.
    format: InventoryFormat,

    /// The prefix that is prepended to all inventory results.
    prefix: ?[]const u8,
};
