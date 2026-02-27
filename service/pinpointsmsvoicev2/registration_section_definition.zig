const RegistrationSectionDisplayHints = @import("registration_section_display_hints.zig").RegistrationSectionDisplayHints;

/// Provides information on the specified section definition.
pub const RegistrationSectionDefinition = struct {
    /// The path to the section of the registration.
    display_hints: RegistrationSectionDisplayHints,

    /// The path to the section of the registration.
    section_path: []const u8,

    pub const json_field_names = .{
        .display_hints = "DisplayHints",
        .section_path = "SectionPath",
    };
};
