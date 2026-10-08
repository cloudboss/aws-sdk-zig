/// Configuration for the Domain web application, including Identity Center
/// settings. If provided, all fields are required.
pub const WebAppConfiguration = struct {
    /// ARN of the IAM role used for EHR operations.
    ehr_role: []const u8,

    /// The Identity Center application ID associated with this Domain.
    idc_application_id: []const u8,

    /// The AWS region where Identity Center is configured.
    idc_region: []const u8,

    pub const json_field_names = .{
        .ehr_role = "ehrRole",
        .idc_application_id = "idcApplicationId",
        .idc_region = "idcRegion",
    };
};
