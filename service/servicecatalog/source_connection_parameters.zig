const CodeStarParameters = @import("code_star_parameters.zig").CodeStarParameters;

/// Provides connection details.
pub const SourceConnectionParameters = struct {
    /// Provides `ConnectionType` details.
    code_star: ?CodeStarParameters = null,

    pub const json_field_names = .{
        .code_star = "CodeStar",
    };
};
