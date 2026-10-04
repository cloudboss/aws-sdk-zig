const ProviderConfig = @import("provider_config.zig").ProviderConfig;
const DlpAction = @import("dlp_action.zig").DlpAction;
const DlpProviderType = @import("dlp_provider_type.zig").DlpProviderType;
const DlpSettingStatus = @import("dlp_setting_status.zig").DlpSettingStatus;

/// The full configuration details of a DLP setting.
pub const DlpSettingDetails = struct {
    /// The Amazon Resource Name (ARN) of the DLP setting.
    arn: []const u8,

    /// The date and time that the DLP setting was created, in ISO 8601 format.
    created_at: i64,

    /// The ID of the DLP setting.
    dlp_setting_id: []const u8,

    /// The display name of the DLP setting.
    name: []const u8,

    /// The provider-specific configuration for the DLP integration.
    provider_config: ProviderConfig,

    /// The behavior applied when the DLP provider is unreachable. Valid values are
    /// `ALLOW`, `WARN`, and `BLOCK`.
    provider_outage_action: DlpAction,

    /// The type of external DLP provider used for sensitivity label classification.
    provider_type: DlpProviderType,

    /// The status of the DLP setting. Valid values are `ACTIVE` and `INACTIVE`.
    status: DlpSettingStatus,

    /// The date and time that the DLP setting was most recently updated, in ISO
    /// 8601 format.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .dlp_setting_id = "DlpSettingId",
        .name = "Name",
        .provider_config = "ProviderConfig",
        .provider_outage_action = "ProviderOutageAction",
        .provider_type = "ProviderType",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
