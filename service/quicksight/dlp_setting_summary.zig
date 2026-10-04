const DlpProviderType = @import("dlp_provider_type.zig").DlpProviderType;
const DlpSettingStatus = @import("dlp_setting_status.zig").DlpSettingStatus;

/// A summary of a DLP setting returned by list operations.
pub const DlpSettingSummary = struct {
    /// The Amazon Resource Name (ARN) of the DLP setting.
    arn: []const u8,

    /// The date and time that the DLP setting was created, in ISO 8601 format.
    created_at: i64,

    /// The ID of the DLP setting.
    dlp_setting_id: []const u8,

    /// The display name of the DLP setting.
    name: []const u8,

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
        .provider_type = "ProviderType",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
