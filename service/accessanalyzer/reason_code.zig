pub const ReasonCode = enum {
    aws_service_access_disabled,
    delegated_administrator_deregistered,
    organization_deleted,
    service_linked_role_creation_failed,

    pub const json_field_names = .{
        .aws_service_access_disabled = "AWS_SERVICE_ACCESS_DISABLED",
        .delegated_administrator_deregistered = "DELEGATED_ADMINISTRATOR_DEREGISTERED",
        .organization_deleted = "ORGANIZATION_DELETED",
        .service_linked_role_creation_failed = "SERVICE_LINKED_ROLE_CREATION_FAILED",
    };
};
