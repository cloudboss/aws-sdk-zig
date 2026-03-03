const QueryCompileErrorLocation = @import("query_compile_error_location.zig").QueryCompileErrorLocation;

/// Reserved.
pub const QueryCompileError = struct {
    /// Reserved.
    location: ?QueryCompileErrorLocation = null,

    /// Reserved.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .location = "location",
        .message = "message",
    };
};
