/// Details related to problems with AWS TNB resources.
pub const ProblemDetails = struct {
    /// A human-readable explanation specific to this occurrence of the problem.
    detail: []const u8,

    /// A human-readable title of the problem type.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .detail = "detail",
        .title = "title",
    };
};
