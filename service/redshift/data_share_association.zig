const DataShareStatus = @import("data_share_status.zig").DataShareStatus;

/// The association of a datashare from a producer account with a data consumer.
pub const DataShareAssociation = struct {
    /// Specifies whether write operations were allowed during data share
    /// association.
    consumer_accepted_writes: ?bool,

    /// The name of the consumer accounts that have an association with a producer
    /// datashare.
    consumer_identifier: ?[]const u8,

    /// The Amazon Web Services Region of the consumer accounts that have an
    /// association with a producer datashare.
    consumer_region: ?[]const u8,

    /// The creation date of the datashare that is associated.
    created_date: ?i64,

    /// Specifies whether write operations were allowed during data share
    /// authorization.
    producer_allowed_writes: ?bool,

    /// The status of the datashare that is associated.
    status: ?DataShareStatus,

    /// The status change data of the datashare that is associated.
    status_change_date: ?i64,
};
