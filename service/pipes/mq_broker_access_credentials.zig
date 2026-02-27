/// The Secrets Manager secret that stores your broker credentials.
pub const MQBrokerAccessCredentials = union(enum) {
    /// The ARN of the Secrets Manager secret.
    basic_auth: ?[]const u8,

    pub const json_field_names = .{
        .basic_auth = "BasicAuth",
    };
};
