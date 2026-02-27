const aws = @import("aws");

/// Summary information about a stage.
pub const StageSummary = struct {
    /// ID of the active session within the stage.
    active_session_id: ?[]const u8,

    /// Stage ARN.
    arn: []const u8,

    /// Stage name.
    name: ?[]const u8,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging AWS Resources and Tag
    /// Editor* for details, including restrictions that apply to tags and "Tag
    /// naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .active_session_id = "activeSessionId",
        .arn = "arn",
        .name = "name",
        .tags = "tags",
    };
};
