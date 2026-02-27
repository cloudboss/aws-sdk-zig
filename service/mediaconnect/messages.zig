/// Messages that provide the state of the flow.
pub const Messages = struct {
    /// A list of errors that might have been generated from processes on this flow.
    errors: []const []const u8,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};
