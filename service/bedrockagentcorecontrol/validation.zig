const NumberValidation = @import("number_validation.zig").NumberValidation;
const StringListValidation = @import("string_list_validation.zig").StringListValidation;
const StringValidation = @import("string_validation.zig").StringValidation;

/// Validation rules for extracted metadata values. Only one type can be
/// specified, matching the field's data type.
pub const Validation = union(enum) {
    number_validation: ?NumberValidation,
    string_list_validation: ?StringListValidation,
    string_validation: ?StringValidation,

    pub const json_field_names = .{
        .number_validation = "numberValidation",
        .string_list_validation = "stringListValidation",
        .string_validation = "stringValidation",
    };
};
