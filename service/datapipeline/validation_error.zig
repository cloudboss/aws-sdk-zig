/// Defines a validation error. Validation errors prevent pipeline activation.
/// The set of validation errors that can be returned are defined by AWS Data
/// Pipeline.
pub const ValidationError = struct {
    /// A description of the validation error.
    errors: ?[]const []const u8 = null,

    /// The identifier of the object that contains the validation error.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .errors = "errors",
        .id = "id",
    };
};
