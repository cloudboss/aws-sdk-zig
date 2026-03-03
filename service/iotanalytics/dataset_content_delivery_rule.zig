const DatasetContentDeliveryDestination = @import("dataset_content_delivery_destination.zig").DatasetContentDeliveryDestination;

/// When dataset contents are created, they are delivered to destination
/// specified
/// here.
pub const DatasetContentDeliveryRule = struct {
    /// The destination to which dataset contents are delivered.
    destination: DatasetContentDeliveryDestination,

    /// The name of the dataset content delivery rules entry.
    entry_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination = "destination",
        .entry_name = "entryName",
    };
};
