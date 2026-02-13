/// Information about the user or resource that created an OpsItem event.
pub const OpsItemIdentity = struct {
    /// The Amazon Resource Name (ARN) of the IAM entity that created the OpsItem
    /// event.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
