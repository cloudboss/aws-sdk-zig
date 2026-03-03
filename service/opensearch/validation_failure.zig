/// A validation failure that occurred as the result of a pre-update validation
/// check
/// (verbose dry run) on a domain.
pub const ValidationFailure = struct {
    /// The error code of the failure.
    code: ?[]const u8 = null,

    /// A message corresponding to the failure.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
