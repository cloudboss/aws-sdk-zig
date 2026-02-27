const QueryCompileErrorLocation = @import("query_compile_error_location.zig").QueryCompileErrorLocation;

/// Reserved.
pub const QueryCompileError = struct {
    /// Reserved.
    location: ?QueryCompileErrorLocation,

    /// Reserved.
    message: ?[]const u8,

    pub const json_field_names = .{
        .location = "location",
        .message = "message",
    };
};
