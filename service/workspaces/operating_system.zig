const OperatingSystemType = @import("operating_system_type.zig").OperatingSystemType;

/// The operating system that the image is running.
pub const OperatingSystem = struct {
    /// The operating system.
    type: ?OperatingSystemType,

    pub const json_field_names = .{
        .type = "Type",
    };
};
