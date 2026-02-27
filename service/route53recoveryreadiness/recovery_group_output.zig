const aws = @import("aws");

/// A representation of the application, typically containing multiple cells.
pub const RecoveryGroupOutput = struct {
    /// A list of a cell's Amazon Resource Names (ARNs).
    cells: []const []const u8,

    /// The Amazon Resource Name (ARN) for the recovery group.
    recovery_group_arn: []const u8,

    /// The name of the recovery group.
    recovery_group_name: []const u8,

    /// The tags associated with the recovery group.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .cells = "Cells",
        .recovery_group_arn = "RecoveryGroupArn",
        .recovery_group_name = "RecoveryGroupName",
        .tags = "Tags",
    };
};
