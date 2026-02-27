/// The attributes of an `Endpoint`.
pub const EndpointAttributes = struct {
    /// The device token for the GCM, APNS, and APNS_SANDBOX endpoint types.
    device_token: []const u8,

    /// The VOIP device token for the APNS and APNS_SANDBOX endpoint types.
    voip_device_token: ?[]const u8,

    pub const json_field_names = .{
        .device_token = "DeviceToken",
        .voip_device_token = "VoipDeviceToken",
    };
};
