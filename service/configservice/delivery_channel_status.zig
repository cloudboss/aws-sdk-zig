const ConfigExportDeliveryInfo = @import("config_export_delivery_info.zig").ConfigExportDeliveryInfo;
const ConfigStreamDeliveryInfo = @import("config_stream_delivery_info.zig").ConfigStreamDeliveryInfo;

/// The status of a specified delivery channel.
///
/// Valid values: `Success` | `Failure`
pub const DeliveryChannelStatus = struct {
    /// A list that contains the status of the delivery of the
    /// configuration history to the specified Amazon S3 bucket.
    config_history_delivery_info: ?ConfigExportDeliveryInfo,

    /// A list containing the status of the delivery of the snapshot to
    /// the specified Amazon S3 bucket.
    config_snapshot_delivery_info: ?ConfigExportDeliveryInfo,

    /// A list containing the status of the delivery of the
    /// configuration stream notification to the specified Amazon SNS
    /// topic.
    config_stream_delivery_info: ?ConfigStreamDeliveryInfo,

    /// The name of the delivery channel.
    name: ?[]const u8,

    pub const json_field_names = .{
        .config_history_delivery_info = "configHistoryDeliveryInfo",
        .config_snapshot_delivery_info = "configSnapshotDeliveryInfo",
        .config_stream_delivery_info = "configStreamDeliveryInfo",
        .name = "name",
    };
};
