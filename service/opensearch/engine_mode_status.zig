const EngineMode = @import("engine_mode.zig").EngineMode;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of the engine mode for the domain.
pub const EngineModeStatus = struct {
    /// The engine mode configured for the domain.
    options: EngineMode,

    /// The current status of the engine mode for the domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
