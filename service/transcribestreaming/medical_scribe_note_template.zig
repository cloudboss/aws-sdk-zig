pub const MedicalScribeNoteTemplate = enum {
    history_and_physical,
    girpp,
    dap,
    sirp,
    birp,
    behavioral_soap,
    physical_soap,

    pub const json_field_names = .{
        .history_and_physical = "HISTORY_AND_PHYSICAL",
        .girpp = "GIRPP",
        .dap = "DAP",
        .sirp = "SIRP",
        .birp = "BIRP",
        .behavioral_soap = "BEHAVIORAL_SOAP",
        .physical_soap = "PHYSICAL_SOAP",
    };
};
