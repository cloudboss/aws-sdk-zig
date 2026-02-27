const RuntimeContext = @import("runtime_context.zig").RuntimeContext;
const ProcessDetails = @import("process_details.zig").ProcessDetails;

/// Information about the process and any required context values for a specific
/// finding.
pub const RuntimeDetails = struct {
    /// Additional information about the suspicious activity.
    context: ?RuntimeContext,

    /// Information about the observed process.
    process: ?ProcessDetails,

    pub const json_field_names = .{
        .context = "Context",
        .process = "Process",
    };
};
