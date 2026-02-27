const KnownGenderType = @import("known_gender_type.zig").KnownGenderType;

/// The known gender identity for the celebrity that matches the provided ID.
/// The known
/// gender identity can be Male, Female, Nonbinary, or Unlisted.
pub const KnownGender = struct {
    /// A string value of the KnownGender info about the Celebrity.
    type: ?KnownGenderType,

    pub const json_field_names = .{
        .type = "Type",
    };
};
