/// A failed resource. For a list of common causes, see [API failure
/// reasons](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/api_failures_messages.html) in the *Amazon Elastic Container Service Developer
/// Guide*.
pub const Failure = struct {
    /// The Amazon Resource Name (ARN) of the failed resource.
    arn: ?[]const u8 = null,

    /// The details of the failure.
    detail: ?[]const u8 = null,

    /// The reason for the failure.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .detail = "detail",
        .reason = "reason",
    };
};
