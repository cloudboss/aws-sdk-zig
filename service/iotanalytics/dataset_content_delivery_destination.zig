const IotEventsDestinationConfiguration = @import("iot_events_destination_configuration.zig").IotEventsDestinationConfiguration;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;

/// The destination to which dataset contents are delivered.
pub const DatasetContentDeliveryDestination = struct {
    /// Configuration information for delivery of dataset contents to IoT Events.
    iot_events_destination_configuration: ?IotEventsDestinationConfiguration,

    /// Configuration information for delivery of dataset contents to Amazon S3.
    s_3_destination_configuration: ?S3DestinationConfiguration,

    pub const json_field_names = .{
        .iot_events_destination_configuration = "iotEventsDestinationConfiguration",
        .s_3_destination_configuration = "s3DestinationConfiguration",
    };
};
