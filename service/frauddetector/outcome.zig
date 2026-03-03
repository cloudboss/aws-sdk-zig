/// The outcome.
pub const Outcome = struct {
    /// The outcome ARN.
    arn: ?[]const u8 = null,

    /// The timestamp when the outcome was created.
    created_time: ?[]const u8 = null,

    /// The outcome description.
    description: ?[]const u8 = null,

    /// The timestamp when the outcome was last updated.
    last_updated_time: ?[]const u8 = null,

    /// The outcome name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
