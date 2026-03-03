const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const IngestionDestinationStatus = @import("ingestion_destination_status.zig").IngestionDestinationStatus;

/// Contains information about an ingestion destination.
pub const IngestionDestination = struct {
    /// The Amazon Resource Name (ARN) of the ingestion destination.
    arn: []const u8,

    /// The timestamp of when the ingestion destination was created.
    created_at: ?i64 = null,

    /// Contains information about the destination of ingested data.
    destination_configuration: DestinationConfiguration,

    /// The Amazon Resource Name (ARN) of the ingestion.
    ingestion_arn: []const u8,

    /// Contains information about how ingested data is processed.
    processing_configuration: ProcessingConfiguration,

    /// The state of the ingestion destination.
    ///
    /// The following states are possible:
    ///
    /// * `Active`: The ingestion destination is active and is ready to be
    /// used.
    ///
    /// * `Failed`: The ingestion destination has failed. If the ingestion
    /// destination is in this state, you should verify the ingestion destination
    /// configuration and try again.
    status: ?IngestionDestinationStatus = null,

    /// The reason for the current status of the ingestion destination.
    ///
    /// Only present when the `status` of ingestion destination is
    /// `Failed`.
    status_reason: ?[]const u8 = null,

    /// The timestamp of when the ingestion destination was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .destination_configuration = "destinationConfiguration",
        .ingestion_arn = "ingestionArn",
        .processing_configuration = "processingConfiguration",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
