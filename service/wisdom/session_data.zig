const aws = @import("aws");

const SessionIntegrationConfiguration = @import("session_integration_configuration.zig").SessionIntegrationConfiguration;

/// Information about the session.
pub const SessionData = struct {
    /// The description of the session.
    description: ?[]const u8 = null,

    /// The configuration information for the session integration.
    integration_configuration: ?SessionIntegrationConfiguration = null,

    /// The name of the session.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the session.
    session_arn: []const u8,

    /// The identifier of the session.
    session_id: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .integration_configuration = "integrationConfiguration",
        .name = "name",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
        .tags = "tags",
    };
};
