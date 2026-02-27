pub const CreateFleetResponse = struct {
    /// The ARN of the created fleet.
    arn: []const u8,

    /// The ID of the created fleet.
    id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
    };
};
