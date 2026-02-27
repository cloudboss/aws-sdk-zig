const Validator = @import("validator.zig").Validator;

/// Array of up to 10 validators.
pub const ValidationDataConfig = struct {
    /// Information about the validators.
    validators: []const Validator,

    pub const json_field_names = .{
        .validators = "validators",
    };
};
