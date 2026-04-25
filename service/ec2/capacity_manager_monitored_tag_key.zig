const CapacityManagerMonitoredTagKeyStatus = @import("capacity_manager_monitored_tag_key_status.zig").CapacityManagerMonitoredTagKeyStatus;

/// Describes a tag key that is being monitored by Capacity Manager, including
/// its activation status and the earliest available data point.
pub const CapacityManagerMonitoredTagKey = struct {
    /// Indicates whether this tag key is provided by Capacity Manager by default,
    /// rather than being user-activated.
    capacity_manager_provided: ?bool = null,

    /// The earliest timestamp from which tag data is available for queries, in UTC
    /// ISO 8601 format.
    earliest_datapoint_timestamp: ?i64 = null,

    /// The current status of the monitored tag key. Valid values are `activating`,
    /// `activated`, `deactivating`, and `suspended`.
    status: ?CapacityManagerMonitoredTagKeyStatus = null,

    /// A message providing additional details about the current status of the
    /// monitored tag key.
    status_message: ?[]const u8 = null,

    /// The tag key being monitored.
    tag_key: ?[]const u8 = null,
};
