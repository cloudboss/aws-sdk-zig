/// Details for an encounter
pub const PatientInsightsEncounterContext = struct {
    /// Chief complaint for the visit
    encounter_reason: []const u8,

    pub const json_field_names = .{
        .encounter_reason = "encounterReason",
    };
};
