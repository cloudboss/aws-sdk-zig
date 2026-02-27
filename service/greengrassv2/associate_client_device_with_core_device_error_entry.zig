/// Contains an error that occurs from a request to associate a client device
/// with a core
/// device. The
/// [BatchAssociateClientDeviceWithCoreDevice](https://docs.aws.amazon.com/greengrass/v2/APIReference/API_BatchAssociateClientDeviceWithCoreDevice.html) operation returns a list of these
/// errors.
pub const AssociateClientDeviceWithCoreDeviceErrorEntry = struct {
    /// The error code for the request.
    code: ?[]const u8,

    /// A message that provides additional information about the error.
    message: ?[]const u8,

    /// The name of the IoT thing whose associate request failed.
    thing_name: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .thing_name = "thingName",
    };
};
