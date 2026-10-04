const CodeLocation = @import("code_location.zig").CodeLocation;

/// A union that identifies the location to instrument. Specify a `CodeLocation`
/// for code-level instrumentation.
pub const Location = union(enum) {
    /// A code location for code-level instrumentation, including language, code
    /// unit, class, method, file path, and optional line number.
    code_location: ?CodeLocation,

    pub const json_field_names = .{
        .code_location = "CodeLocation",
    };
};
