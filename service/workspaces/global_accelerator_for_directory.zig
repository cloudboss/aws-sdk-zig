const AGAModeForDirectoryEnum = @import("aga_mode_for_directory_enum.zig").AGAModeForDirectoryEnum;
const AGAPreferredProtocolForDirectory = @import("aga_preferred_protocol_for_directory.zig").AGAPreferredProtocolForDirectory;

/// Describes the Global Accelerator for directory
pub const GlobalAcceleratorForDirectory = struct {
    /// Indicates if Global Accelerator for directory is enabled or disabled.
    mode: AGAModeForDirectoryEnum,

    /// Indicates the preferred protocol for Global Accelerator.
    preferred_protocol: ?AGAPreferredProtocolForDirectory = null,

    pub const json_field_names = .{
        .mode = "Mode",
        .preferred_protocol = "PreferredProtocol",
    };
};
