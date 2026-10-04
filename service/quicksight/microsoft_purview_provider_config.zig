const MicrosoftPurviewCredentials = @import("microsoft_purview_credentials.zig").MicrosoftPurviewCredentials;
const LabelActionMapping = @import("label_action_mapping.zig").LabelActionMapping;
const DlpAction = @import("dlp_action.zig").DlpAction;

/// The full configuration for Microsoft Purview DLP integration, including the
/// provider credentials and the label-action mappings that define the
/// enforcement policy.
pub const MicrosoftPurviewProviderConfig = struct {
    /// The credentials used to authenticate with Microsoft Purview.
    credentials: MicrosoftPurviewCredentials,

    /// The mappings from Microsoft Purview sensitivity labels to enforcement
    /// actions.
    label_action_mappings: []const LabelActionMapping,

    /// The default action to apply to content that has no sensitivity label or
    /// whose label is not mapped. Valid values are `ALLOW`, `BLOCK`, and `WARN`.
    unmapped_action: DlpAction,

    pub const json_field_names = .{
        .credentials = "Credentials",
        .label_action_mappings = "LabelActionMappings",
        .unmapped_action = "UnmappedAction",
    };
};
