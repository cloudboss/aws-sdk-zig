const OSType = @import("os_type.zig").OSType;

/// Information about the operating system.
pub const OSInfo = struct {
    /// Information about the type of operating system.
    @"type": ?OSType,

    /// Information about the version of operating system.
    version: ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "type",
        .version = "version",
    };
};
