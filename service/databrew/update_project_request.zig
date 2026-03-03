const Sample = @import("sample.zig").Sample;

pub const UpdateProjectRequest = struct {
    /// The name of the project to be updated.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role to be assumed for this
    /// request.
    role_arn: []const u8,

    sample: ?Sample = null,

    pub const json_field_names = .{
        .name = "Name",
        .role_arn = "RoleArn",
        .sample = "Sample",
    };
};
