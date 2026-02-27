/// The IAM principal that subscribes to the asset.
pub const SubscribedIamPrincipal = struct {
    /// The ARN of the subscribed IAM principal.
    principal_arn: ?[]const u8,

    pub const json_field_names = .{
        .principal_arn = "principalArn",
    };
};
