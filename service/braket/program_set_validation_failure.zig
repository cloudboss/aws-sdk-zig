/// Contains information about validation failures that occurred during the
/// processing of a program set in a quantum task.
pub const ProgramSetValidationFailure = struct {
    /// A list of error messages describing the validation failures that occurred.
    errors: ?[]const []const u8 = null,

    /// The index of the input within the program set that failed validation.
    inputs_index: ?i64 = null,

    /// The index of the program within the program set that failed validation.
    program_index: i64,

    pub const json_field_names = .{
        .errors = "errors",
        .inputs_index = "inputsIndex",
        .program_index = "programIndex",
    };
};
