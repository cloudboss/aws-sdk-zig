const NumberCapability = @import("number_capability.zig").NumberCapability;
const NotifyConfigurationStatus = @import("notify_configuration_status.zig").NotifyConfigurationStatus;
const NotifyConfigurationTier = @import("notify_configuration_tier.zig").NotifyConfigurationTier;
const TierUpgradeStatus = @import("tier_upgrade_status.zig").TierUpgradeStatus;
const NotifyConfigurationUseCase = @import("notify_configuration_use_case.zig").NotifyConfigurationUseCase;

/// The information for a notify configuration in an Amazon Web Services
/// account.
pub const NotifyConfigurationInformation = struct {
    /// The time when the notify configuration was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The default template identifier associated with the notify configuration.
    default_template_id: ?[]const u8 = null,

    /// When set to true deletion protection is enabled. By default this is set to
    /// false.
    deletion_protection_enabled: bool = false,

    /// The display name associated with the notify configuration.
    display_name: []const u8,

    /// An array of channels enabled for the notify configuration. Supported values
    /// include `SMS` and `VOICE`.
    enabled_channels: []const NumberCapability,

    /// An array of two-character ISO country codes, in ISO 3166-1 alpha-2 format,
    /// that are enabled for the notify configuration.
    enabled_countries: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) for the notify configuration.
    notify_configuration_arn: []const u8,

    /// The unique identifier for the notify configuration.
    notify_configuration_id: []const u8,

    /// The identifier of the pool associated with the notify configuration.
    pool_id: ?[]const u8 = null,

    /// The reason the notify configuration was rejected, if applicable.
    rejection_reason: ?[]const u8 = null,

    /// The current status of the notify configuration.
    status: NotifyConfigurationStatus,

    /// The tier of the notify configuration.
    tier: NotifyConfigurationTier,

    /// The tier upgrade status of the notify configuration.
    tier_upgrade_status: TierUpgradeStatus,

    /// The use case for the notify configuration.
    use_case: NotifyConfigurationUseCase,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .default_template_id = "DefaultTemplateId",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .display_name = "DisplayName",
        .enabled_channels = "EnabledChannels",
        .enabled_countries = "EnabledCountries",
        .notify_configuration_arn = "NotifyConfigurationArn",
        .notify_configuration_id = "NotifyConfigurationId",
        .pool_id = "PoolId",
        .rejection_reason = "RejectionReason",
        .status = "Status",
        .tier = "Tier",
        .tier_upgrade_status = "TierUpgradeStatus",
        .use_case = "UseCase",
    };
};
