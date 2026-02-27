pub const SNOMEDCTEntityCategory = enum {
    medical_condition,
    anatomy,
    test_treatment_procedure,

    pub const json_field_names = .{
        .medical_condition = "MEDICAL_CONDITION",
        .anatomy = "ANATOMY",
        .test_treatment_procedure = "TEST_TREATMENT_PROCEDURE",
    };
};
