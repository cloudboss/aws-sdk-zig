/// Defines IAM instance profile configuration for WorkSpace Instance.
pub const IamInstanceProfileSpecification = struct {
    /// Amazon Resource Name (ARN) of the IAM instance profile.
    arn: ?[]const u8,

    /// Name of the IAM instance profile.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
