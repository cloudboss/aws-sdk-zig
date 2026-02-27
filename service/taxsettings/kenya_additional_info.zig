const PersonType = @import("person_type.zig").PersonType;

/// Additional tax information associated with your TRN in Kenya.
pub const KenyaAdditionalInfo = struct {
    /// The legal person or physical person assigned to this TRN in Kenya.
    person_type: PersonType,

    pub const json_field_names = .{
        .person_type = "personType",
    };
};
