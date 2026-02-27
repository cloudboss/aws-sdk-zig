pub const ComplianceType = enum {
    compliant,
    non_compliant,
    not_applicable,
    insufficient_data,

    pub const json_field_names = .{
        .compliant = "Compliant",
        .non_compliant = "Non_Compliant",
        .not_applicable = "Not_Applicable",
        .insufficient_data = "Insufficient_Data",
    };
};
