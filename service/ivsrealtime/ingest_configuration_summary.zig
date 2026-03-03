const IngestProtocol = @import("ingest_protocol.zig").IngestProtocol;
const IngestConfigurationState = @import("ingest_configuration_state.zig").IngestConfigurationState;

/// Summary information about an IngestConfiguration.
pub const IngestConfigurationSummary = struct {
    /// Ingest configuration ARN.
    arn: []const u8,

    /// Type of ingest protocol that the user employs for broadcasting.
    ingest_protocol: IngestProtocol,

    /// Ingest name.
    name: ?[]const u8 = null,

    /// ID of the participant within the stage.
    participant_id: []const u8,

    /// ARN of the stage with which the IngestConfiguration is associated.
    stage_arn: []const u8,

    /// State of the ingest configuration. It is `ACTIVE` if a publisher currently
    /// is
    /// publishing to the stage associated with the ingest configuration.
    state: IngestConfigurationState,

    /// Customer-assigned name to help identify the participant using the
    /// IngestConfiguration;
    /// this can be used to link a participant to a user in the customer’s own
    /// systems. This can be
    /// any UTF-8 encoded text. *This field is exposed to all stage participants and
    /// should not be used for personally identifying, confidential, or sensitive
    /// information.*
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .ingest_protocol = "ingestProtocol",
        .name = "name",
        .participant_id = "participantId",
        .stage_arn = "stageArn",
        .state = "state",
        .user_id = "userId",
    };
};
