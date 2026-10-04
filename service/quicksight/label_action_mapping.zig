const DlpAction = @import("dlp_action.zig").DlpAction;

/// Maps a sensitivity label from Microsoft Purview to an enforcement action.
pub const LabelActionMapping = struct {
    /// The enforcement action to apply when content with this sensitivity label is
    /// detected. Valid values are `ALLOW`, `BLOCK`, and `WARN`.
    action: DlpAction,

    /// The identifier of the sensitivity label from the DLP provider.
    label_id: []const u8,

    /// The display name of the sensitivity label from the DLP provider.
    label_name: []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .label_id = "LabelId",
        .label_name = "LabelName",
    };
};
