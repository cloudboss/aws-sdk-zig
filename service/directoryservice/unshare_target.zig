const TargetType = @import("target_type.zig").TargetType;

/// Identifier that contains details about the directory consumer account with
/// whom the
/// directory is being unshared.
pub const UnshareTarget = struct {
    /// Identifier of the directory consumer account.
    id: []const u8,

    /// Type of identifier to be used in the *Id* field.
    type: TargetType,

    pub const json_field_names = .{
        .id = "Id",
        .type = "Type",
    };
};
