/// An AWS IoT thing.
pub const Thing = struct {
    /// The ARN of the thing.
    thing_arn: ?[]const u8,

    /// The name of the thing.
    thing_name: ?[]const u8,

    pub const json_field_names = .{
        .thing_arn = "thingArn",
        .thing_name = "thingName",
    };
};
