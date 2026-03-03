const Pronouns = @import("pronouns.zig").Pronouns;

/// Contains patient-specific information used to customize the clinical note
/// generation.
pub const MedicalScribePatientContext = struct {
    /// The patient's preferred pronouns that the user wants to provide as a context
    /// for clinical note generation.
    pronouns: ?Pronouns = null,

    pub const json_field_names = .{
        .pronouns = "Pronouns",
    };
};
