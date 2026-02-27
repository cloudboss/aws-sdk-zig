pub const AssociationOption = enum {
    apply_application_tag,
    skip_application_tag,

    pub const json_field_names = .{
        .apply_application_tag = "APPLY_APPLICATION_TAG",
        .skip_application_tag = "SKIP_APPLICATION_TAG",
    };
};
