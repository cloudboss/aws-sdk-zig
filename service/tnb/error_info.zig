/// Provides error information.
pub const ErrorInfo = struct {
    /// Error cause.
    cause: ?[]const u8,

    /// Error details.
    details: ?[]const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .details = "details",
    };
};
