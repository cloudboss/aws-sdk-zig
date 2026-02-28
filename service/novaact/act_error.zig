/// Error information when an act fails to execute successfully.
pub const ActError = struct {
    /// A human-readable description of the error that occurred.
    message: []const u8,

    /// The type or category of error that occurred.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .message = "message",
        .@"type" = "type",
    };
};
