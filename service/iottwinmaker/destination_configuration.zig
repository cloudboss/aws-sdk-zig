const IotTwinMakerDestinationConfiguration = @import("iot_twin_maker_destination_configuration.zig").IotTwinMakerDestinationConfiguration;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const DestinationType = @import("destination_type.zig").DestinationType;

/// The [link to action] metadata transfer job destination configuration.
pub const DestinationConfiguration = struct {
    /// The metadata transfer job Amazon Web Services IoT TwinMaker configuration.
    iot_twin_maker_configuration: ?IotTwinMakerDestinationConfiguration,

    /// The metadata transfer job S3 configuration. [need to add S3 entity]
    s_3_configuration: ?S3DestinationConfiguration,

    /// The destination type.
    type: DestinationType,

    pub const json_field_names = .{
        .iot_twin_maker_configuration = "iotTwinMakerConfiguration",
        .s_3_configuration = "s3Configuration",
        .type = "type",
    };
};
