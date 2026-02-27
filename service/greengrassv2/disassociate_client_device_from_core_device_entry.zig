/// Contains a request to disassociate a client device from a core device. The
/// [BatchDisassociateClientDeviceWithCoreDevice](https://docs.aws.amazon.com/greengrass/v2/APIReference/API_BatchDisassociateClientDeviceWithCoreDevice.html) operation consumes a list of these
/// requests.
pub const DisassociateClientDeviceFromCoreDeviceEntry = struct {
    /// The name of the IoT thing that represents the client device to disassociate.
    thing_name: []const u8,

    pub const json_field_names = .{
        .thing_name = "thingName",
    };
};
