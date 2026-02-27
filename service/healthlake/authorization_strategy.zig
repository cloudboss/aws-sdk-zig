pub const AuthorizationStrategy = enum {
    smartv1,
    smart_on_fhir,
    aws_auth,

    pub const json_field_names = .{
        .smartv1 = "SMARTV1",
        .smart_on_fhir = "SMART_ON_FHIR",
        .aws_auth = "AWS_AUTH",
    };
};
