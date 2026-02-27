const MqttTopicConfig = @import("mqtt_topic_config.zig").MqttTopicConfig;
const S3Config = @import("s3_config.zig").S3Config;
const TimestreamConfig = @import("timestream_config.zig").TimestreamConfig;

/// The destination where the campaign sends data. You can send data to an MQTT
/// topic,
/// or store it in Amazon S3 or Amazon Timestream.
pub const DataDestinationConfig = union(enum) {
    /// The MQTT topic to which the Amazon Web Services IoT FleetWise campaign
    /// routes data.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    mqtt_topic_config: ?MqttTopicConfig,
    /// The Amazon S3 bucket where the Amazon Web Services IoT FleetWise campaign
    /// sends data.
    s_3_config: ?S3Config,
    /// The Amazon Timestream table where the campaign sends data.
    timestream_config: ?TimestreamConfig,

    pub const json_field_names = .{
        .mqtt_topic_config = "mqttTopicConfig",
        .s_3_config = "s3Config",
        .timestream_config = "timestreamConfig",
    };
};
