pub const RegistrationStatus = enum {
    created,
    submitted,
    aws_reviewing,
    reviewing,
    requires_authentication,
    provisioning,
    complete,
    requires_updates,
    closed,
    deleted,

    pub const json_field_names = .{
        .created = "CREATED",
        .submitted = "SUBMITTED",
        .aws_reviewing = "AWS_REVIEWING",
        .reviewing = "REVIEWING",
        .requires_authentication = "REQUIRES_AUTHENTICATION",
        .provisioning = "PROVISIONING",
        .complete = "COMPLETE",
        .requires_updates = "REQUIRES_UPDATES",
        .closed = "CLOSED",
        .deleted = "DELETED",
    };
};
