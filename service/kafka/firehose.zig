pub const Firehose = struct {
    delivery_stream: ?[]const u8 = null,

    enabled: bool,

    pub const json_field_names = .{
        .delivery_stream = "DeliveryStream",
        .enabled = "Enabled",
    };
};
