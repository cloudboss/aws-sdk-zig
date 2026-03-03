const aws = @import("aws");

const ConnectorSsmCommandConfig = @import("connector_ssm_command_config.zig").ConnectorSsmCommandConfig;

pub const Connector = struct {
    /// Connector arn.
    arn: ?[]const u8 = null,

    /// Connector ID.
    connector_id: ?[]const u8 = null,

    /// Connector name.
    name: ?[]const u8 = null,

    /// Connector SSM command config.
    ssm_command_config: ?ConnectorSsmCommandConfig = null,

    /// Connector SSM instance ID.
    ssm_instance_id: ?[]const u8 = null,

    /// Connector tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .connector_id = "connectorID",
        .name = "name",
        .ssm_command_config = "ssmCommandConfig",
        .ssm_instance_id = "ssmInstanceID",
        .tags = "tags",
    };
};
