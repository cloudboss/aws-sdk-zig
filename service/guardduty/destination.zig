const DestinationType = @import("destination_type.zig").DestinationType;
const PublishingStatus = @import("publishing_status.zig").PublishingStatus;

/// Contains information about the publishing destination, including the ID,
/// type, and
/// status.
pub const Destination = struct {
    /// The unique ID of the publishing destination.
    destination_id: []const u8,

    /// The type of resource used for the publishing destination. Currently, only
    /// Amazon S3
    /// buckets are supported.
    destination_type: DestinationType,

    /// The status of the publishing destination.
    status: PublishingStatus,

    pub const json_field_names = .{
        .destination_id = "DestinationId",
        .destination_type = "DestinationType",
        .status = "Status",
    };
};
