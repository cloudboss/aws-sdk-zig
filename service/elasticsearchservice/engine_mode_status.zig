const DomainEngineMode = @import("domain_engine_mode.zig").DomainEngineMode;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of the engine mode for the domain.
pub const EngineModeStatus = struct {
    /// The engine mode configured for the domain.
    options: DomainEngineMode,

    /// The current status of the engine mode for the domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
