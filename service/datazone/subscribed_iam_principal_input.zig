/// The details of the subscribed IAM principal.
pub const SubscribedIamPrincipalInput = struct {
    /// The ARN of the subscribed IAM principal.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};
