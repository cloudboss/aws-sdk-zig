const aws = @import("aws");

const AutoParticipantRecordingConfiguration = @import("auto_participant_recording_configuration.zig").AutoParticipantRecordingConfiguration;
const StageEndpoints = @import("stage_endpoints.zig").StageEndpoints;

/// Object specifying a stage.
pub const Stage = struct {
    /// ID of the active session within the stage.
    active_session_id: ?[]const u8 = null,

    /// Stage ARN.
    arn: []const u8,

    /// Configuration object for individual participant recording, attached to the
    /// stage.
    auto_participant_recording_configuration: ?AutoParticipantRecordingConfiguration = null,

    /// Summary information about various endpoints for a stage.
    endpoints: ?StageEndpoints = null,

    /// Stage name.
    name: ?[]const u8 = null,

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

    pub const json_field_names = .{
        .active_session_id = "activeSessionId",
        .arn = "arn",
        .auto_participant_recording_configuration = "autoParticipantRecordingConfiguration",
        .endpoints = "endpoints",
        .name = "name",
        .tags = "tags",
    };
};
