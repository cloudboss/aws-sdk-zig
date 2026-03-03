const RootCauseException = @import("root_cause_exception.zig").RootCauseException;

/// A collection of segments and corresponding subsegments associated to a trace
/// summary
/// fault error.
pub const FaultRootCauseEntity = struct {
    /// The types and messages of the exceptions.
    exceptions: ?[]const RootCauseException = null,

    /// The name of the entity.
    name: ?[]const u8 = null,

    /// A flag that denotes a remote subsegment.
    remote: ?bool = null,

    pub const json_field_names = .{
        .exceptions = "Exceptions",
        .name = "Name",
        .remote = "Remote",
    };
};
