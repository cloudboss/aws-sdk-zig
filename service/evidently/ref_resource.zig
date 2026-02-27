/// A structure that contains information about one experiment or launch that
/// uses the specified segment.
pub const RefResource = struct {
    /// The ARN of the experiment or launch.
    arn: ?[]const u8,

    /// The day and time that this experiment or launch ended.
    end_time: ?[]const u8,

    /// The day and time that this experiment or launch was most recently updated.
    last_updated_on: ?[]const u8,

    /// The name of the experiment or launch.
    name: []const u8,

    /// The day and time that this experiment or launch started.
    start_time: ?[]const u8,

    /// The status of the experiment or launch.
    status: ?[]const u8,

    /// Specifies whether the resource that this structure contains information
    /// about is an experiment or a launch.
    type: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .end_time = "endTime",
        .last_updated_on = "lastUpdatedOn",
        .name = "name",
        .start_time = "startTime",
        .status = "status",
        .type = "type",
    };
};
