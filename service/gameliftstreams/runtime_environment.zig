const RuntimeEnvironmentType = @import("runtime_environment_type.zig").RuntimeEnvironmentType;

/// Configuration settings that identify the operating system for an application
/// resource. This can also include a compatibility layer and other drivers.
///
/// A runtime environment can be one of the following:
///
/// * For Linux applications
///
/// * Ubuntu 22.04 LTS (`Type=UBUNTU, Version=22_04_LTS`)
///
/// * For Windows applications
///
/// * Microsoft Windows Server 2022 Base (`Type=WINDOWS, Version=2022`)
/// * Proton 9.0-2 (`Type=PROTON, Version=20250516`)
/// * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
/// * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
pub const RuntimeEnvironment = struct {
    /// The operating system and other drivers. For Proton, this also includes the
    /// Proton compatibility layer.
    type: RuntimeEnvironmentType,

    /// Versioned container environment for the application operating system.
    version: []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .version = "Version",
    };
};
