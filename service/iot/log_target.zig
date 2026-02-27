const LogTargetType = @import("log_target_type.zig").LogTargetType;

/// A log target.
pub const LogTarget = struct {
    /// The target name.
    target_name: ?[]const u8,

    /// The target type.
    target_type: LogTargetType,

    pub const json_field_names = .{
        .target_name = "targetName",
        .target_type = "targetType",
    };
};
