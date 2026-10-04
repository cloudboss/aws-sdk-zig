const DeletionProtectionConfiguration = @import("deletion_protection_configuration.zig").DeletionProtectionConfiguration;
const MediaExtractionConfiguration = @import("media_extraction_configuration.zig").MediaExtractionConfiguration;
const SyncSchedule = @import("sync_schedule.zig").SyncSchedule;

/// Configuration for managed knowledge base connector data sources.
pub const ManagedKnowledgeBaseConnectorConfiguration = struct {
    /// Connector-specific parameters. For more information, see [Connect a data
    /// source](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-managed-connect-ds.html).
    connector_parameters: ?[]const u8 = null,

    /// A safeguard against accidental bulk deletion of indexed content.
    deletion_protection_configuration: ?DeletionProtectionConfiguration = null,

    /// Configuration for extracting media (images, audio, video) from data source
    /// files.
    media_extraction_configuration: ?MediaExtractionConfiguration = null,

    /// The recurring schedule on which the connector automatically syncs this data
    /// source. If not specified, the data source is not synced automatically and
    /// you start each sync yourself. Not supported for the Custom connector.
    sync_schedule: ?SyncSchedule = null,

    pub const json_field_names = .{
        .connector_parameters = "connectorParameters",
        .deletion_protection_configuration = "deletionProtectionConfiguration",
        .media_extraction_configuration = "mediaExtractionConfiguration",
        .sync_schedule = "syncSchedule",
    };
};
