/// Contains an error that occurs from a request to disassociate a client device
/// from a core
/// device. The
/// [BatchDisassociateClientDeviceWithCoreDevice](https://docs.aws.amazon.com/greengrass/v2/APIReference/API_BatchDisassociateClientDeviceWithCoreDevice.html) operation returns a list of these
/// errors.
pub const DisassociateClientDeviceFromCoreDeviceErrorEntry = struct {
    /// The error code for the request.
    code: ?[]const u8,

    /// A message that provides additional information about the error.
    message: ?[]const u8,

    /// The name of the IoT thing whose disassociate request failed.
    thing_name: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .thing_name = "thingName",
    };
};
