const SnsConfiguration = @import("sns_configuration.zig").SnsConfiguration;

/// Notification configuration for a scheduled query. A notification is sent by
/// Timestream
/// when a scheduled query is created, its state is updated or when it is
/// deleted.
pub const NotificationConfiguration = struct {
    /// Details about the Amazon Simple Notification Service (SNS) configuration.
    /// This field is visible only when SNS Topic is provided when updating the
    /// account settings.
    sns_configuration: SnsConfiguration,

    pub const json_field_names = .{
        .sns_configuration = "SnsConfiguration",
    };
};
