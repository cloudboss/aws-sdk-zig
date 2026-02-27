/// A direct source or destination neighbor to an AWS media resource.
pub const MediaResourceNeighbor = struct {
    /// The ARN of a resource used in AWS media workflows.
    arn: []const u8,

    /// The logical name of an AWS media resource.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
