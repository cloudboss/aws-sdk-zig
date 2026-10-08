const AdditionalServiceDetails = @import("additional_service_details.zig").AdditionalServiceDetails;
const Service = @import("service.zig").Service;

/// Represents a registered service with its configuration and accessible
/// resources.
pub const RegisteredService = struct {
    /// List of accessible resources for this service.
    accessible_resources: ?[]const []const u8 = null,

    /// Additional details specific to the service type.
    additional_service_details: ?AdditionalServiceDetails = null,

    /// The timestamp when the service was registered.
    created_at: i64,

    /// The ARN of the AWS Key Management Service (AWS KMS) customer managed key
    /// that's used to encrypt resources.
    kms_key_arn: ?[]const u8 = null,

    /// The display name of the registered service.
    name: ?[]const u8 = null,

    /// The name of the private connection used for VPC connectivity.
    private_connection_name: ?[]const u8 = null,

    /// The unique identifier of a service.
    service_id: []const u8,

    /// The service type e.g github or dynatrace
    service_type: Service,

    /// The timestamp when the service was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .accessible_resources = "accessibleResources",
        .additional_service_details = "additionalServiceDetails",
        .created_at = "createdAt",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .private_connection_name = "privateConnectionName",
        .service_id = "serviceId",
        .service_type = "serviceType",
        .updated_at = "updatedAt",
    };
};
