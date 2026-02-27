/// Provides details about the broker usernames for the specified broker.
/// Doesn't apply to RabbitMQ brokers.
pub const AwsAmazonMqBrokerUsersDetails = struct {
    /// The type of change pending for the broker user.
    pending_change: ?[]const u8,

    /// The username of the broker user.
    username: ?[]const u8,

    pub const json_field_names = .{
        .pending_change = "PendingChange",
        .username = "Username",
    };
};
