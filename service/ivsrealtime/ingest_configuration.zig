const aws = @import("aws");

const IngestProtocol = @import("ingest_protocol.zig").IngestProtocol;
const IngestConfigurationState = @import("ingest_configuration_state.zig").IngestConfigurationState;

/// Object specifying an ingest configuration.
pub const IngestConfiguration = struct {
    /// Ingest configuration ARN.
    arn: []const u8,

    /// Application-provided attributes to to store in the IngestConfiguration and
    /// attach to a
    /// stage. Map keys and values can contain UTF-8 encoded text. The maximum
    /// length of this field
    /// is 1 KB total. *This field is exposed to all stage participants and should
    /// not be
    /// used for personally identifying, confidential, or sensitive
    /// information.*
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// Type of ingest protocol that the user employs for broadcasting.
    ingest_protocol: IngestProtocol,

    /// Ingest name
    name: ?[]const u8 = null,

    /// ID of the participant within the stage.
    participant_id: []const u8,

    /// ARN of the stage with which the IngestConfiguration is associated.
    stage_arn: []const u8,

    /// State of the ingest configuration. It is `ACTIVE` if a publisher currently
    /// is
    /// publishing to the stage associated with the ingest configuration.
    state: IngestConfigurationState,

    /// Ingest-key value for the RTMP(S) protocol.
    stream_key: []const u8,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging AWS Resources and Tag
    /// Editor* for details, including restrictions that apply to tags and "Tag
    /// naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry = null,

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
        .attributes = "attributes",
        .ingest_protocol = "ingestProtocol",
        .name = "name",
        .participant_id = "participantId",
        .stage_arn = "stageArn",
        .state = "state",
        .stream_key = "streamKey",
        .tags = "tags",
        .user_id = "userId",
    };
};
