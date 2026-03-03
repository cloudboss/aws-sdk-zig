const aws = @import("aws");

/// A column in a `Table`.
pub const Column = struct {
    /// A free-form text comment.
    comment: ?[]const u8 = null,

    /// The name of the `Column`.
    name: []const u8,

    /// These key-value pairs define properties associated with the column.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The data type of the `Column`.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .comment = "Comment",
        .name = "Name",
        .parameters = "Parameters",
        .@"type" = "Type",
    };
};
