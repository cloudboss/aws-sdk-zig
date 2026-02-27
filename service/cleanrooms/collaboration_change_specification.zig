const AutoApprovedChangeType = @import("auto_approved_change_type.zig").AutoApprovedChangeType;

/// Defines the specific changes being requested for a collaboration, including
/// configuration modifications and approval requirements.
pub const CollaborationChangeSpecification = struct {
    /// Defines requested updates to properties of the collaboration. Currently,
    /// this only supports modifying which change types are auto-approved for the
    /// collaboration.
    auto_approved_change_types: ?[]const AutoApprovedChangeType,

    pub const json_field_names = .{
        .auto_approved_change_types = "autoApprovedChangeTypes",
    };
};
