const OwnershipSettingsSummary = @import("ownership_settings_summary.zig").OwnershipSettingsSummary;
const SpaceSettingsSummary = @import("space_settings_summary.zig").SpaceSettingsSummary;
const SpaceSharingSettingsSummary = @import("space_sharing_settings_summary.zig").SpaceSharingSettingsSummary;
const SpaceStatus = @import("space_status.zig").SpaceStatus;

/// The space's details.
pub const SpaceDetails = struct {
    /// The creation time.
    creation_time: ?i64,

    /// The ID of the associated domain.
    domain_id: ?[]const u8,

    /// The last modified time.
    last_modified_time: ?i64,

    /// Specifies summary information about the ownership settings.
    ownership_settings_summary: ?OwnershipSettingsSummary,

    /// The name of the space that appears in the Studio UI.
    space_display_name: ?[]const u8,

    /// The name of the space.
    space_name: ?[]const u8,

    /// Specifies summary information about the space settings.
    space_settings_summary: ?SpaceSettingsSummary,

    /// Specifies summary information about the space sharing settings.
    space_sharing_settings_summary: ?SpaceSharingSettingsSummary,

    /// The status.
    status: ?SpaceStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .domain_id = "DomainId",
        .last_modified_time = "LastModifiedTime",
        .ownership_settings_summary = "OwnershipSettingsSummary",
        .space_display_name = "SpaceDisplayName",
        .space_name = "SpaceName",
        .space_settings_summary = "SpaceSettingsSummary",
        .space_sharing_settings_summary = "SpaceSharingSettingsSummary",
        .status = "Status",
    };
};
