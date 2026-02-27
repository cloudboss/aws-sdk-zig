const Code = @import("code.zig").Code;
const AgentManagedRuntimeType = @import("agent_managed_runtime_type.zig").AgentManagedRuntimeType;

/// The configuration for the source code that defines how the agent runtime
/// code should be executed, including the code location, runtime environment,
/// and entry point.
pub const CodeConfiguration = struct {
    /// The source code location and configuration details.
    code: Code,

    /// The entry point for the code execution, specifying the function or method
    /// that should be invoked when the code runs.
    entry_point: []const []const u8,

    /// The runtime environment for executing the code (for example, Python 3.9 or
    /// Node.js 18).
    runtime: AgentManagedRuntimeType,

    pub const json_field_names = .{
        .code = "code",
        .entry_point = "entryPoint",
        .runtime = "runtime",
    };
};
