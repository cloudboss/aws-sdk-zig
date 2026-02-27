/// Represents a request to the delete project operation.
pub const DeleteProjectRequest = struct {
    /// Represents the Amazon Resource Name (ARN) of the Device Farm project to
    /// delete.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
