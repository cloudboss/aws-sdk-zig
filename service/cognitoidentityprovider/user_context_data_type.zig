/// Contextual data, such as the user's device fingerprint, IP address, or
/// location, used
/// for evaluating the risk of an unexpected event by Amazon Cognito threat
/// protection.
pub const UserContextDataType = struct {
    /// Encoded device-fingerprint details that your app collected with the Amazon
    /// Cognito
    /// context data collection library. For more information, see [Adding user
    /// device and session data to API
    /// requests](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-adaptive-authentication.html#user-pool-settings-adaptive-authentication-device-fingerprint).
    encoded_data: ?[]const u8,

    /// The source IP address of your user's device.
    ip_address: ?[]const u8,

    pub const json_field_names = .{
        .encoded_data = "EncodedData",
        .ip_address = "IpAddress",
    };
};
