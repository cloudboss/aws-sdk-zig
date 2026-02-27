/// Represents a custom network interface as defined by the customer.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const CustomDecodingInterface = struct {
    /// The name of the interface.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
