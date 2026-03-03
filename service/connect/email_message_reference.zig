/// Information about the reference when the referenceType is `EMAIL_MESSAGE`.
/// Otherwise, null.
pub const EmailMessageReference = struct {
    /// The Amazon Resource Name (ARN) of the email message reference
    arn: ?[]const u8 = null,

    /// The name of the email message reference
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
