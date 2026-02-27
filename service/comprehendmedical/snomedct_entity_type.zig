pub const SNOMEDCTEntityType = enum {
    dx_name,
    test_name,
    procedure_name,
    treatment_name,

    pub const json_field_names = .{
        .dx_name = "DX_NAME",
        .test_name = "TEST_NAME",
        .procedure_name = "PROCEDURE_NAME",
        .treatment_name = "TREATMENT_NAME",
    };
};
