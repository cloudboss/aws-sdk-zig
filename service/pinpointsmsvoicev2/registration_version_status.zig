pub const RegistrationVersionStatus = enum {
    draft,
    submitted,
    aws_reviewing,
    reviewing,
    requires_authentication,
    approved,
    discarded,
    denied,
    revoked,
    archived,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .submitted = "SUBMITTED",
        .aws_reviewing = "AWS_REVIEWING",
        .reviewing = "REVIEWING",
        .requires_authentication = "REQUIRES_AUTHENTICATION",
        .approved = "APPROVED",
        .discarded = "DISCARDED",
        .denied = "DENIED",
        .revoked = "REVOKED",
        .archived = "ARCHIVED",
    };
};
