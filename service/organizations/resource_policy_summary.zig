/// A structure that contains resource policy ID and Amazon Resource Name (ARN).
pub const ResourcePolicySummary = struct {
    /// The Amazon Resource Name (ARN) of the resource policy.
    arn: ?[]const u8,

    /// The unique identifier (ID) of the resource policy.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
