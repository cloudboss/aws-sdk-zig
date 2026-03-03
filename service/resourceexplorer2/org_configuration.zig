const AWSServiceAccessStatus = @import("aws_service_access_status.zig").AWSServiceAccessStatus;

/// This is a structure that contains the status of Amazon Web Services service
/// access, and whether you have a valid service-linked role to enable
/// multi-account search for your organization.
pub const OrgConfiguration = struct {
    /// This value displays whether your Amazon Web Services service access is
    /// `ENABLED` or `DISABLED`.
    aws_service_access_status: AWSServiceAccessStatus,

    /// This value shows whether or not you have a valid a service-linked role
    /// required to start the multi-account search feature.
    service_linked_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_service_access_status = "AWSServiceAccessStatus",
        .service_linked_role = "ServiceLinkedRole",
    };
};
