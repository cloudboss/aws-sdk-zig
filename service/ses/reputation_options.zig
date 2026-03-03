/// Contains information about the reputation settings for a configuration set.
pub const ReputationOptions = struct {
    /// The date and time at which the reputation metrics for the configuration set
    /// were last
    /// reset. Resetting these metrics is known as a *fresh start*.
    ///
    /// When you disable email sending for a configuration set using
    /// UpdateConfigurationSetSendingEnabled and later re-enable it, the
    /// reputation metrics for the configuration set (but not for the entire Amazon
    /// SES account) are
    /// reset.
    ///
    /// If email sending for the configuration set has never been disabled and later
    /// re-enabled, the value of this attribute is `null`.
    last_fresh_start: ?i64 = null,

    /// Describes whether or not Amazon SES publishes reputation metrics for the
    /// configuration set,
    /// such as bounce and complaint rates, to Amazon CloudWatch.
    ///
    /// If the value is `true`, reputation metrics are published. If the value is
    /// `false`, reputation metrics are not published. The default value is
    /// `false`.
    reputation_metrics_enabled: bool = false,

    /// Describes whether email sending is enabled or disabled for the configuration
    /// set. If
    /// the value is `true`, then Amazon SES sends emails that use the configuration
    /// set.
    /// If the value is `false`, Amazon SES does not send emails that use the
    /// configuration set. The default value is `true`. You can change this setting
    /// using UpdateConfigurationSetSendingEnabled.
    sending_enabled: bool = false,
};
