/// The details of a QuickSight resource in a space.
pub const SpaceQuickSightResourceDetails = union(enum) {
    /// The ARN of the QuickSight resource.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
