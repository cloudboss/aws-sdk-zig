const LogsLocation = @import("logs_location.zig").LogsLocation;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const SandboxSessionPhase = @import("sandbox_session_phase.zig").SandboxSessionPhase;

/// Contains information about the sandbox session.
pub const SandboxSession = struct {
    /// The current phase for the sandbox.
    current_phase: ?[]const u8,

    /// When the sandbox session ended, expressed in Unix time format.
    end_time: ?i64,

    /// The ID of the sandbox session.
    id: ?[]const u8,

    logs: ?LogsLocation,

    network_interface: ?NetworkInterface,

    /// An array of `SandboxSessionPhase` objects.
    phases: ?[]const SandboxSessionPhase,

    /// An identifier for the version of this sandbox's source code.
    resolved_source_version: ?[]const u8,

    /// When the sandbox session started, expressed in Unix time format.
    start_time: ?i64,

    /// The status of the sandbox session.
    status: ?[]const u8,

    pub const json_field_names = .{
        .current_phase = "currentPhase",
        .end_time = "endTime",
        .id = "id",
        .logs = "logs",
        .network_interface = "networkInterface",
        .phases = "phases",
        .resolved_source_version = "resolvedSourceVersion",
        .start_time = "startTime",
        .status = "status",
    };
};
