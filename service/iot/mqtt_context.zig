/// Specifies the MQTT context to use for the test authorizer request
pub const MqttContext = struct {
    /// The value of the `clientId` key in an MQTT authorization request.
    client_id: ?[]const u8 = null,

    /// The value of the `password` key in an MQTT authorization request.
    password: ?[]const u8 = null,

    /// The value of the `username` key in an MQTT authorization request.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .password = "password",
        .username = "username",
    };
};
