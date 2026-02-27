pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the contact, escalation plan, rotation, or
    /// on-call
    /// schedule.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
