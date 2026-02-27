/// Contains metadata about the quantum task action, including the action type
/// and program statistics.
pub const ActionMetadata = struct {
    /// The type of action associated with the quantum task.
    action_type: []const u8,

    /// The number of executables in a program set. This is only available for a
    /// program set.
    executable_count: ?i64,

    /// The number of programs in a program set. This is only available for a
    /// program set.
    program_count: ?i64,

    pub const json_field_names = .{
        .action_type = "actionType",
        .executable_count = "executableCount",
        .program_count = "programCount",
    };
};
