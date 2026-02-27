const AGAModeForWorkSpaceEnum = @import("aga_mode_for_work_space_enum.zig").AGAModeForWorkSpaceEnum;
const AGAPreferredProtocolForWorkSpace = @import("aga_preferred_protocol_for_work_space.zig").AGAPreferredProtocolForWorkSpace;

/// Describes the Global Accelerator for WorkSpaces.
pub const GlobalAcceleratorForWorkSpace = struct {
    /// Indicates if Global Accelerator for WorkSpaces is enabled, disabled,
    /// or the same mode as the associated directory.
    mode: AGAModeForWorkSpaceEnum,

    /// Indicates the preferred protocol for Global Accelerator.
    preferred_protocol: ?AGAPreferredProtocolForWorkSpace,

    pub const json_field_names = .{
        .mode = "Mode",
        .preferred_protocol = "PreferredProtocol",
    };
};
