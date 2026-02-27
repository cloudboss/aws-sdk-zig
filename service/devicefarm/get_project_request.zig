/// Represents a request to the get project operation.
pub const GetProjectRequest = struct {
    /// The project's ARN.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
