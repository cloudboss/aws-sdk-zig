const FieldTypeDetails = @import("field_type_details.zig").FieldTypeDetails;

/// Contains details regarding all the supported `FieldTypes` and their
/// corresponding `filterOperators` and `supportedValues`.
pub const SupportedFieldTypeDetails = struct {
    /// The initial supported version for `fieldType`. If this is later changed to a
    /// different version, v2 will be introduced.
    v_1: FieldTypeDetails,

    pub const json_field_names = .{
        .v_1 = "v1",
    };
};
