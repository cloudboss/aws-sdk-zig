/// Describes the enums in a generic data schema.
pub const CodegenGenericDataEnum = struct {
    /// The list of enum values in the generic data schema.
    values: []const []const u8,

    pub const json_field_names = .{
        .values = "values",
    };
};
