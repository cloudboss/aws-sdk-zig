/// Used to associate a configuration set with a MailManager archive.
pub const ArchivingOptions = struct {
    /// The Amazon Resource Name (ARN) of the MailManager archive where the Amazon
    /// SES API v2 will archive sent
    /// emails.
    archive_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .archive_arn = "ArchiveArn",
    };
};
