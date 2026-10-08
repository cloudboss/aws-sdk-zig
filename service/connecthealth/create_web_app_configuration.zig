/// Input configuration for creating a web application. Used only in
/// CreateDomain operation input.
pub const CreateWebAppConfiguration = struct {
    /// ARN of the IAM role used for EHR operations.
    ehr_role: []const u8,

    /// The Identity Center instance ID to use for creating the application.
    idc_instance_id: []const u8,

    /// The AWS region where Identity Center is configured.
    idc_region: []const u8,

    pub const json_field_names = .{
        .ehr_role = "ehrRole",
        .idc_instance_id = "idcInstanceId",
        .idc_region = "idcRegion",
    };
};
