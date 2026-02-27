const LogConfigurationType = @import("log_configuration_type.zig").LogConfigurationType;

/// The logging parameters of a user pool, as returned in the response to a
/// `GetLogDeliveryConfiguration` request.
pub const LogDeliveryConfigurationType = struct {
    /// A logging destination of a user pool. User pools can have multiple logging
    /// destinations for message-delivery and user-activity logs.
    log_configurations: []const LogConfigurationType,

    /// The ID of the user pool where you configured logging.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .log_configurations = "LogConfigurations",
        .user_pool_id = "UserPoolId",
    };
};
