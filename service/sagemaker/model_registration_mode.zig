pub const ModelRegistrationMode = enum {
    auto_model_registration_enabled,
    auto_model_registration_disabled,

    pub const json_field_names = .{
        .auto_model_registration_enabled = "AUTO_MODEL_REGISTRATION_ENABLED",
        .auto_model_registration_disabled = "AUTO_MODEL_REGISTRATION_DISABLED",
    };
};
