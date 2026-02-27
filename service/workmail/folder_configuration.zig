const RetentionAction = @import("retention_action.zig").RetentionAction;
const FolderName = @import("folder_name.zig").FolderName;

/// The configuration applied to an organization's folders by its retention
/// policy.
pub const FolderConfiguration = struct {
    /// The action to take on the folder contents at the end of the folder
    /// configuration
    /// period.
    action: RetentionAction,

    /// The folder name.
    name: FolderName,

    /// The number of days for which the folder-configuration action applies.
    period: ?i32,

    pub const json_field_names = .{
        .action = "Action",
        .name = "Name",
        .period = "Period",
    };
};
