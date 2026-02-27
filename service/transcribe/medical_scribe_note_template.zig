pub const MedicalScribeNoteTemplate = enum {
    history_and_physical,
    girpp,
    birp,
    sirp,
    dap,
    behavioral_soap,
    physical_soap,

    pub const json_field_names = .{
        .history_and_physical = "HISTORY_AND_PHYSICAL",
        .girpp = "GIRPP",
        .birp = "BIRP",
        .sirp = "SIRP",
        .dap = "DAP",
        .behavioral_soap = "BEHAVIORAL_SOAP",
        .physical_soap = "PHYSICAL_SOAP",
    };
};
