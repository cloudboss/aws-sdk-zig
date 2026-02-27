/// Information about a single retained message.
pub const RetainedMessageSummary = struct {
    /// The Epoch date and time, in milliseconds, when the retained message was
    /// stored by IoT.
    last_modified_time: i64 = 0,

    /// The size of the retained message's payload in bytes.
    payload_size: i64 = 0,

    /// The quality of service (QoS) level used to publish the retained message.
    qos: i32 = 0,

    /// The topic name to which the retained message was published.
    topic: ?[]const u8,

    pub const json_field_names = .{
        .last_modified_time = "lastModifiedTime",
        .payload_size = "payloadSize",
        .qos = "qos",
        .topic = "topic",
    };
};
