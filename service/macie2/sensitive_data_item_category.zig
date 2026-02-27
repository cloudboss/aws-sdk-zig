/// For a finding, the category of sensitive data that was detected and produced
/// the finding. For a managed data identifier, the category of sensitive data
/// that the managed data identifier detects. Possible values are:
pub const SensitiveDataItemCategory = enum {
    financial_information,
    personal_information,
    credentials,
    custom_identifier,

    pub const json_field_names = .{
        .financial_information = "FINANCIAL_INFORMATION",
        .personal_information = "PERSONAL_INFORMATION",
        .credentials = "CREDENTIALS",
        .custom_identifier = "CUSTOM_IDENTIFIER",
    };
};
