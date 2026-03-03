/// Information about an error found in a behavior specification.
pub const ValidationError = struct {
    /// The description of an error found in the behaviors.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
    };
};
