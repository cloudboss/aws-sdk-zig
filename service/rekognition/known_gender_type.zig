/// A list of enum string of possible gender values that Celebrity returns.
pub const KnownGenderType = enum {
    male,
    female,
    nonbinary,
    unlisted,

    pub const json_field_names = .{
        .male = "Male",
        .female = "Female",
        .nonbinary = "Nonbinary",
        .unlisted = "Unlisted",
    };
};
