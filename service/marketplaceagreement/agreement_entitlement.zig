const Resource = @import("resource.zig").Resource;
const AgreementEntitlementStatus = @import("agreement_entitlement_status.zig").AgreementEntitlementStatus;
const AgreementEntitlementStatusReasonCode = @import("agreement_entitlement_status_reason_code.zig").AgreementEntitlementStatusReasonCode;

/// Represents an entitlement associated with an agreement, including the
/// provisioning status, resource, and type.
pub const AgreementEntitlement = struct {
    /// The Amazon Resource Name (ARN) of the AWS License Manager license associated
    /// with the entitlement.
    license_arn: ?[]const u8 = null,

    /// A short-lived token required by acceptors to register their account with the
    /// product provider. The token is only valid for 30 minutes after creation and
    /// is only applicable for purchase agreements.
    registration_token: ?[]const u8 = null,

    /// The resource that the entitlement is provisioned to, such as a product.
    resource: ?Resource = null,

    /// The current state of an entitlement.
    status: ?AgreementEntitlementStatus = null,

    /// Provides more information about the status of an entitlement.
    status_reason_code: ?AgreementEntitlementStatusReasonCode = null,

    /// The type of entitlement.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .license_arn = "licenseArn",
        .registration_token = "registrationToken",
        .resource = "resource",
        .status = "status",
        .status_reason_code = "statusReasonCode",
        .@"type" = "type",
    };
};
