const PhysicalEndpoint = @import("physical_endpoint.zig").PhysicalEndpoint;
const ConnectionPropertiesOutput = @import("connection_properties_output.zig").ConnectionPropertiesOutput;
const ConnectionScope = @import("connection_scope.zig").ConnectionScope;
const ConnectionType = @import("connection_type.zig").ConnectionType;

/// The summary of a connection.
pub const ConnectionSummary = struct {
    /// The ID of a connection.
    connection_id: []const u8,

    /// The domain ID of a connection.
    domain_id: []const u8,

    /// The domain unit ID of a connection.
    domain_unit_id: []const u8,

    /// The environment ID of a connection.
    environment_id: ?[]const u8,

    /// The connection name.
    name: []const u8,

    /// The connection physical endpoints.
    physical_endpoints: []const PhysicalEndpoint,

    /// The connection project ID.
    project_id: ?[]const u8,

    /// The connection props.
    props: ?ConnectionPropertiesOutput,

    /// The scope of the connection.
    scope: ?ConnectionScope,

    /// The connection type.
    @"type": ConnectionType,

    pub const json_field_names = .{
        .connection_id = "connectionId",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .environment_id = "environmentId",
        .name = "name",
        .physical_endpoints = "physicalEndpoints",
        .project_id = "projectId",
        .props = "props",
        .scope = "scope",
        .@"type" = "type",
    };
};
