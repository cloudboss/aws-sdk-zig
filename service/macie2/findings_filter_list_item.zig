const aws = @import("aws");

const FindingsFilterAction = @import("findings_filter_action.zig").FindingsFilterAction;

/// Provides information about a findings filter.
pub const FindingsFilterListItem = struct {
    /// The action that's performed on findings that match the filter criteria.
    /// Possible values are: ARCHIVE, suppress (automatically archive) the findings;
    /// and, NOOP, don't perform any action on the findings.
    action: ?FindingsFilterAction = null,

    /// The Amazon Resource Name (ARN) of the filter.
    arn: ?[]const u8 = null,

    /// The unique identifier for the filter.
    id: ?[]const u8 = null,

    /// The custom name of the filter.
    name: ?[]const u8 = null,

    /// A map of key-value pairs that specifies which tags (keys and values) are
    /// associated with the filter.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action = "action",
        .arn = "arn",
        .id = "id",
        .name = "name",
        .tags = "tags",
    };
};
