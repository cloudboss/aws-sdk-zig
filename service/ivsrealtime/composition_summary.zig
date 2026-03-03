const aws = @import("aws");

const DestinationSummary = @import("destination_summary.zig").DestinationSummary;
const CompositionState = @import("composition_state.zig").CompositionState;

/// Summary information about a Composition.
pub const CompositionSummary = struct {
    /// ARN of the Composition resource.
    arn: []const u8,

    /// Array of Destination objects.
    destinations: []const DestinationSummary,

    /// UTC time of the Composition end. This is an ISO 8601 timestamp; *note that
    /// this
    /// is returned as a string*.
    end_time: ?i64 = null,

    /// ARN of the attached stage.
    stage_arn: []const u8,

    /// UTC time of the Composition start. This is an ISO 8601 timestamp; *note that
    /// this is returned as a string*.
    start_time: ?i64 = null,

    /// State of the Composition resource.
    state: CompositionState,

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
        .arn = "arn",
        .destinations = "destinations",
        .end_time = "endTime",
        .stage_arn = "stageArn",
        .start_time = "startTime",
        .state = "state",
        .tags = "tags",
    };
};
