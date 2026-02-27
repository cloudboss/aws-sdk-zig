/// Contains a request to associate a client device with a core device. The
/// [BatchAssociateClientDeviceWithCoreDevice](https://docs.aws.amazon.com/greengrass/v2/APIReference/API_BatchAssociateClientDeviceWithCoreDevice.html) operation consumes a list of these
/// requests.
pub const AssociateClientDeviceWithCoreDeviceEntry = struct {
    /// The name of the IoT thing that represents the client device to associate.
    thing_name: []const u8,

    pub const json_field_names = .{
        .thing_name = "thingName",
    };
};
