/// Contains information about a subscription for an MQTT client, including the
/// topic filter and Quality of Service (QoS) level.
pub const SubscriptionSummary = struct {
    /// The Quality of Service (QoS) level for the subscription. Valid values are 0
    /// (at most once) and 1 (at least once).
    qos: i32 = 0,

    /// The topic filter pattern that the client is subscribed to. May include MQTT
    /// wildcards such as + (single-level) and # (multi-level).
    topic_filter: []const u8,

    pub const json_field_names = .{
        .qos = "qos",
        .topic_filter = "topicFilter",
    };
};
