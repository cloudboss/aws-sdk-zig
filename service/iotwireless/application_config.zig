const ApplicationConfigType = @import("application_config_type.zig").ApplicationConfigType;

/// LoRaWAN application configuration, which can be used to perform geolocation.
pub const ApplicationConfig = struct {
    /// The name of the position data destination that describes the AWS IoT rule
    /// that
    /// processes the device's position data for use by AWS IoT Core for LoRaWAN.
    destination_name: ?[]const u8 = null,

    f_port: ?i32 = null,

    /// Application type, which can be specified to obtain real-time position
    /// information of
    /// your LoRaWAN device.
    @"type": ?ApplicationConfigType = null,

    pub const json_field_names = .{
        .destination_name = "DestinationName",
        .f_port = "FPort",
        .@"type" = "Type",
    };
};
