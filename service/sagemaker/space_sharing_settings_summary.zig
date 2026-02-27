const SharingType = @import("sharing_type.zig").SharingType;

/// Specifies summary information about the space sharing settings.
pub const SpaceSharingSettingsSummary = struct {
    /// Specifies the sharing type of the space.
    sharing_type: ?SharingType,

    pub const json_field_names = .{
        .sharing_type = "SharingType",
    };
};
