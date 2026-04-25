/// Details about delivering logs to Firehose.
pub const ReplicatorFirehose = struct {
    /// The Firehose delivery stream that is the destination for log delivery.
    delivery_stream: ?[]const u8 = null,

    /// Whether log delivery to Firehose is enabled.
    enabled: bool,

    pub const json_field_names = .{
        .delivery_stream = "DeliveryStream",
        .enabled = "Enabled",
    };
};
