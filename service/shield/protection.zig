const ApplicationLayerAutomaticResponseConfiguration = @import("application_layer_automatic_response_configuration.zig").ApplicationLayerAutomaticResponseConfiguration;

/// An object that represents a resource that is under DDoS protection.
pub const Protection = struct {
    /// The automatic application layer DDoS mitigation settings for the protection.
    /// This configuration determines whether Shield Advanced automatically
    /// manages rules in the web ACL in order to respond to application layer events
    /// that Shield Advanced determines to be DDoS attacks.
    application_layer_automatic_response_configuration: ?ApplicationLayerAutomaticResponseConfiguration = null,

    /// The unique identifier (ID) for the Route 53 health check that's associated
    /// with the protection.
    health_check_ids: ?[]const []const u8 = null,

    /// The unique identifier (ID) of the protection.
    id: ?[]const u8 = null,

    /// The name of the protection. For example, `My CloudFront distributions`.
    name: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) of the protection.
    protection_arn: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) of the Amazon Web Services resource that is
    /// protected.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_layer_automatic_response_configuration = "ApplicationLayerAutomaticResponseConfiguration",
        .health_check_ids = "HealthCheckIds",
        .id = "Id",
        .name = "Name",
        .protection_arn = "ProtectionArn",
        .resource_arn = "ResourceArn",
    };
};
