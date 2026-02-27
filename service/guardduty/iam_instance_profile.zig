/// Contains information about the EC2 instance profile.
pub const IamInstanceProfile = struct {
    /// The profile ARN of the EC2 instance.
    arn: ?[]const u8,

    /// The profile ID of the EC2 instance.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
