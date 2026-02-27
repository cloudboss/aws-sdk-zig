/// Describes the solution stack.
pub const SolutionStackDescription = struct {
    /// The permitted file types allowed for a solution stack.
    permitted_file_types: ?[]const []const u8,

    /// The name of the solution stack.
    solution_stack_name: ?[]const u8,
};
