/// Represents the default Amazon GameLift Streams application that a stream
/// group hosts.
pub const DefaultApplication = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    arn: ?[]const u8,

    /// An ID that uniquely identifies the application resource. Example ID:
    /// `a-9ZY8X7Wv6`.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
