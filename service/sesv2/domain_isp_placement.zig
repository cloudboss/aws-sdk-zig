/// An object that contains inbox placement data for email sent from one of your
/// email
/// domains to a specific email provider.
pub const DomainIspPlacement = struct {
    /// The percentage of messages that were sent from the selected domain to the
    /// specified
    /// email provider that arrived in recipients' inboxes.
    inbox_percentage: ?f64,

    /// The total number of messages that were sent from the selected domain to the
    /// specified
    /// email provider that arrived in recipients' inboxes.
    inbox_raw_count: ?i64,

    /// The name of the email provider that the inbox placement data applies to.
    isp_name: ?[]const u8,

    /// The percentage of messages that were sent from the selected domain to the
    /// specified
    /// email provider that arrived in recipients' spam or junk mail folders.
    spam_percentage: ?f64,

    /// The total number of messages that were sent from the selected domain to the
    /// specified
    /// email provider that arrived in recipients' spam or junk mail folders.
    spam_raw_count: ?i64,

    pub const json_field_names = .{
        .inbox_percentage = "InboxPercentage",
        .inbox_raw_count = "InboxRawCount",
        .isp_name = "IspName",
        .spam_percentage = "SpamPercentage",
        .spam_raw_count = "SpamRawCount",
    };
};
