const VoiceConnectorAwsRegion = @import("voice_connector_aws_region.zig").VoiceConnectorAwsRegion;
const VoiceConnectorIntegrationType = @import("voice_connector_integration_type.zig").VoiceConnectorIntegrationType;
const NetworkType = @import("network_type.zig").NetworkType;

/// The Amazon Chime SDK Voice Connector configuration, including outbound
/// host name and encryption settings.
pub const VoiceConnector = struct {
    /// The AWS Region in which the Voice Connector is created.
    /// Default: us-east-1.
    aws_region: ?VoiceConnectorAwsRegion,

    /// The Voice Connector's creation timestamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The connectors for use with Amazon Connect.
    integration_type: ?VoiceConnectorIntegrationType,

    /// The Voice Connector's name.
    name: ?[]const u8,

    /// The type of network of the Voice Connector. Either IPv4 only or dual-stack
    /// (IPv4 and IPv6).
    network_type: ?NetworkType,

    /// The outbound host name for the Voice Connector.
    outbound_host_name: ?[]const u8,

    /// Enables or disables encryption for the Voice Connector.
    require_encryption: ?bool,

    /// The Voice Connector's updated timestamp, in ISO 8601 format.
    updated_timestamp: ?i64,

    /// The ARN of the Voice Connector.
    voice_connector_arn: ?[]const u8,

    /// The Voice Connector's ID.
    voice_connector_id: ?[]const u8,

    pub const json_field_names = .{
        .aws_region = "AwsRegion",
        .created_timestamp = "CreatedTimestamp",
        .integration_type = "IntegrationType",
        .name = "Name",
        .network_type = "NetworkType",
        .outbound_host_name = "OutboundHostName",
        .require_encryption = "RequireEncryption",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_connector_arn = "VoiceConnectorArn",
        .voice_connector_id = "VoiceConnectorId",
    };
};
