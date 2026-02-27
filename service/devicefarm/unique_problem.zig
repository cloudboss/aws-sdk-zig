const Problem = @import("problem.zig").Problem;

/// A collection of one or more problems, grouped by their result.
pub const UniqueProblem = struct {
    /// A message about the unique problems' result.
    message: ?[]const u8,

    /// Information about the problems.
    problems: ?[]const Problem,

    pub const json_field_names = .{
        .message = "message",
        .problems = "problems",
    };
};
