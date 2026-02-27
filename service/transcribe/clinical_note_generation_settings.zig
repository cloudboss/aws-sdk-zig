const MedicalScribeNoteTemplate = @import("medical_scribe_note_template.zig").MedicalScribeNoteTemplate;

/// The output configuration for clinical note generation.
pub const ClinicalNoteGenerationSettings = struct {
    /// Specify one of the following templates to use for the clinical note summary.
    /// The default is `HISTORY_AND_PHYSICAL`.
    ///
    /// * HISTORY_AND_PHYSICAL: Provides summaries for key sections of the clinical
    ///   documentation. Examples of sections include Chief Complaint, History of
    ///   Present Illness, Review of Systems, Past Medical History, Assessment, and
    ///   Plan.
    ///
    /// * GIRPP: Provides summaries based on the patients progress toward goals.
    ///   Examples of sections include Goal, Intervention,
    /// Response, Progress, and Plan.
    ///
    /// * BIRP: Focuses on the patient's behavioral patterns and responses. Examples
    ///   of sections include Behavior, Intervention, Response, and Plan.
    ///
    /// * SIRP: Emphasizes the situational context of therapy. Examples of sections
    ///   include Situation, Intervention, Response, and Plan.
    ///
    /// * DAP: Provides a simplified format for clinical documentation. Examples of
    ///   sections include Data, Assessment, and Plan.
    ///
    /// * BEHAVIORAL_SOAP: Behavioral health focused documentation format. Examples
    ///   of sections include Subjective, Objective, Assessment, and Plan.
    ///
    /// * PHYSICAL_SOAP: Physical health focused documentation format. Examples of
    ///   sections include Subjective, Objective, Assessment, and Plan.
    note_template: ?MedicalScribeNoteTemplate,

    pub const json_field_names = .{
        .note_template = "NoteTemplate",
    };
};
