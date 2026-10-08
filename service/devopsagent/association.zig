const aws = @import("aws");

const CapabilityConfiguration = @import("capability_configuration.zig").CapabilityConfiguration;
const ServiceConfiguration = @import("service_configuration.zig").ServiceConfiguration;
const ValidationStatus = @import("validation_status.zig").ValidationStatus;

/// Represents a service association within an AgentSpace, defining how the
/// agent interacts with external services.
pub const Association = struct {
    /// The unique identifier of the AgentSpace
    agent_space_id: []const u8,

    /// The unique identifier of the given association.
    association_id: []const u8,

    /// Enabled capabilities for this association.
    capabilities: ?[]const aws.map.MapEntry(CapabilityConfiguration) = null,

    /// The configuration that directs how AgentSpace interacts with the given
    /// service.
    configuration: ServiceConfiguration,

    /// The timestamp when the resource was created.
    created_at: i64,

    /// The identifier for associated service
    service_id: []const u8,

    /// Validation status
    status: ?ValidationStatus = null,

    /// The timestamp when the resource was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .association_id = "associationId",
        .capabilities = "capabilities",
        .configuration = "configuration",
        .created_at = "createdAt",
        .service_id = "serviceId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
