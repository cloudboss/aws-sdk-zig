/// The label details.
pub const Label = struct {
    /// The label ARN.
    arn: ?[]const u8,

    /// Timestamp of when the event type was created.
    created_time: ?[]const u8,

    /// The label description.
    description: ?[]const u8,

    /// Timestamp of when the label was last updated.
    last_updated_time: ?[]const u8,

    /// The label name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
