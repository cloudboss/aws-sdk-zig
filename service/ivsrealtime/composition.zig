const aws = @import("aws");

const Destination = @import("destination.zig").Destination;
const LayoutConfiguration = @import("layout_configuration.zig").LayoutConfiguration;
const CompositionState = @import("composition_state.zig").CompositionState;

/// Object specifying a Composition resource.
pub const Composition = struct {
    /// ARN of the Composition resource.
    arn: []const u8,

    /// Array of Destination objects. A Composition can contain either one
    /// destination
    /// (`channel` or `s3`) or two (one `channel` and one
    /// `s3`).
    destinations: []const Destination,

    /// UTC time of the Composition end. This is an ISO 8601 timestamp; *note that
    /// this
    /// is returned as a string*.
    end_time: ?i64 = null,

    /// Layout object to configure composition parameters.
    layout: LayoutConfiguration,

    /// ARN of the stage used as input
    stage_arn: []const u8,

    /// UTC time of the Composition start. This is an ISO 8601 timestamp; *note that
    /// this is returned as a string*.
    start_time: ?i64 = null,

    /// State of the Composition.
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
        .layout = "layout",
        .stage_arn = "stageArn",
        .start_time = "startTime",
        .state = "state",
        .tags = "tags",
    };
};
