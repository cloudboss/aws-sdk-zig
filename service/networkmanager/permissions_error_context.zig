/// Describes additional information about missing permissions.
pub const PermissionsErrorContext = struct {
    /// The missing permissions.
    missing_permission: ?[]const u8,

    pub const json_field_names = .{
        .missing_permission = "MissingPermission",
    };
};
