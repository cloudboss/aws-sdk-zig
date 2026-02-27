/// Provides information about a failed administrative action.
pub const AdministrativeActionFailureDetails = struct {
    /// Error message providing details about the failed administrative action.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
