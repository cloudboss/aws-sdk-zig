const PersonType = @import("person_type.zig").PersonType;

/// Additional tax information associated with your TRN in Georgia.
pub const GeorgiaAdditionalInfo = struct {
    /// The legal person or physical person assigned to this TRN in Georgia.
    person_type: PersonType,

    pub const json_field_names = .{
        .person_type = "personType",
    };
};
