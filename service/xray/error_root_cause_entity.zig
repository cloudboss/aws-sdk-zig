const RootCauseException = @import("root_cause_exception.zig").RootCauseException;

/// A collection of segments and corresponding subsegments associated to a trace
/// summary
/// error.
pub const ErrorRootCauseEntity = struct {
    /// The types and messages of the exceptions.
    exceptions: ?[]const RootCauseException,

    /// The name of the entity.
    name: ?[]const u8,

    /// A flag that denotes a remote subsegment.
    remote: ?bool,

    pub const json_field_names = .{
        .exceptions = "Exceptions",
        .name = "Name",
        .remote = "Remote",
    };
};
