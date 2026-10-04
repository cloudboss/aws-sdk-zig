/// A single error encountered while creating or reading a web function
/// revision. The error describes the affected attribute, an error code, and a
/// human-readable message. This structure is present only when the revision has
/// errors.
pub const RevisionError = struct {
    /// The name of the revision attribute that the error applies to. Must be
    /// between 1 and 64 characters.
    attribute: []const u8,

    /// A short, machine-readable code that identifies the error. Must be between 1
    /// and 64 characters.
    error_code: []const u8,

    /// A human-readable message describing the error. Must be between 1 and 2048
    /// characters.
    error_message: []const u8,

    pub const json_field_names = .{
        .attribute = "attribute",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
