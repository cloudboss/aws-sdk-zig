const TrackingConfigurationOverrides = @import("tracking_configuration_overrides.zig").TrackingConfigurationOverrides;

/// An object that overrides settings for a single email sending request. An
/// override
/// applies only to the message or messages in the request that contains it. It
/// doesn't
/// change your account-level settings, and it doesn't change the configuration
/// set that the
/// request uses.
///
/// A setting that you don't override keeps the value that would otherwise apply
/// to the
/// message. Depending on the setting, that value comes from the configuration
/// set that the
/// message uses, from your account-level settings, or from the Amazon SES
/// default.
pub const ConfigurationOverrides = struct {
    /// An object that overrides the open and click tracking settings that would
    /// otherwise
    /// apply to the message.
    tracking: ?TrackingConfigurationOverrides = null,

    pub const json_field_names = .{
        .tracking = "Tracking",
    };
};
