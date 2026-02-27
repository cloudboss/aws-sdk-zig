pub const MalaysiaServiceTaxCode = enum {
    consultancy,
    digital_svc_electronic_medium,
    it_services,
    training_or_coaching,

    pub const json_field_names = .{
        .consultancy = "CONSULTANCY",
        .digital_svc_electronic_medium = "DIGITAL_SVC_ELECTRONIC_MEDIUM",
        .it_services = "IT_SERVICES",
        .training_or_coaching = "TRAINING_OR_COACHING",
    };
};
