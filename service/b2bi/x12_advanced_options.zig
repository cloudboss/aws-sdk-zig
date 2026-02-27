const X12SplitOptions = @import("x12_split_options.zig").X12SplitOptions;
const X12ValidationOptions = @import("x12_validation_options.zig").X12ValidationOptions;

/// Contains advanced options specific to X12 EDI processing, such as splitting
/// large X12 files into smaller units.
pub const X12AdvancedOptions = struct {
    /// Specifies options for splitting X12 EDI files. These options control how
    /// large X12 files are divided into smaller, more manageable units.
    split_options: ?X12SplitOptions,

    /// Specifies validation options for X12 EDI processing. These options control
    /// how validation rules are applied during EDI document processing, including
    /// custom validation rules for element length constraints, code list
    /// validations, and element requirement checks.
    validation_options: ?X12ValidationOptions,

    pub const json_field_names = .{
        .split_options = "splitOptions",
        .validation_options = "validationOptions",
    };
};
