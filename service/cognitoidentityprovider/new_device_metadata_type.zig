/// Information that your user pool responds with in `AuthenticationResult`when
/// you configure it to remember devices and a user signs in with an
/// unrecognized device.
/// Amazon Cognito presents a new device key that you can use to set up [device
/// authentication](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html) in a "Remember me on this device"
/// authentication model.
pub const NewDeviceMetadataType = struct {
    /// The device group key, an identifier used in generating the
    /// `DEVICE_PASSWORD_VERIFIER` for device SRP authentication.
    device_group_key: ?[]const u8 = null,

    /// The device key, an identifier used in generating the
    /// `DEVICE_PASSWORD_VERIFIER` for device SRP authentication.
    device_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_group_key = "DeviceGroupKey",
        .device_key = "DeviceKey",
    };
};
