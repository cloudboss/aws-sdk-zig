/// A user associated with the broker. For Amazon MQ for RabbitMQ brokers, one
/// and only one administrative user is accepted and created when a broker is
/// first provisioned. All subsequent broker users are created by making
/// RabbitMQ API calls directly to brokers or via the RabbitMQ web console.
pub const User = struct {
    /// Enables access to the ActiveMQ Web Console for the ActiveMQ user. Does not
    /// apply to RabbitMQ brokers.
    console_access: ?bool = null,

    /// The list of groups (20 maximum) to which the ActiveMQ user belongs. This
    /// value can contain only alphanumeric characters, dashes, periods,
    /// underscores, and tildes (- . _ ~). This value must be 2-100 characters long.
    /// Does not apply to RabbitMQ brokers.
    groups: ?[]const []const u8 = null,

    /// Required. The password of the user. This value must be at least 12
    /// characters long, must contain at least 4 unique characters, and must not
    /// contain commas, colons, or equal signs (,:=).
    password: []const u8,

    /// Defines if this user is intended for CRDR replication purposes.
    replication_user: ?bool = null,

    /// The username of the broker user. The following restrictions apply to broker
    /// usernames:
    ///
    /// * For Amazon MQ for ActiveMQ brokers, this value can contain only
    ///   alphanumeric characters, dashes, periods, underscores, and tildes (- . _
    ///   ~). This value must be 2-100 characters long.
    /// * para>For Amazon MQ for RabbitMQ brokers, this value can contain only
    ///   alphanumeric characters, dashes, periods, underscores (- . _). This value
    ///   must not contain a tilde (~) character. Amazon MQ prohibts using guest as
    ///   a valid usename. This value must be 2-100 characters long.
    ///
    /// Do not add personally identifiable information (PII) or other confidential
    /// or sensitive information in broker usernames. Broker usernames are
    /// accessible to other Amazon Web Services services, including CloudWatch Logs.
    /// Broker usernames are not intended to be used for private or sensitive data.
    username: []const u8,

    pub const json_field_names = .{
        .console_access = "ConsoleAccess",
        .groups = "Groups",
        .password = "Password",
        .replication_user = "ReplicationUser",
        .username = "Username",
    };
};
