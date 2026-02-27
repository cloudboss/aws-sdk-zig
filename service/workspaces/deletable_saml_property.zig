pub const DeletableSamlProperty = enum {
    saml_properties_user_access_url,
    saml_properties_relay_state_parameter_name,

    pub const json_field_names = .{
        .saml_properties_user_access_url = "SAML_PROPERTIES_USER_ACCESS_URL",
        .saml_properties_relay_state_parameter_name = "SAML_PROPERTIES_RELAY_STATE_PARAMETER_NAME",
    };
};
