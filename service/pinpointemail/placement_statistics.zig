/// An object that contains inbox placement data for an email provider.
pub const PlacementStatistics = struct {
    /// The percentage of emails that were authenticated by using DomainKeys
    /// Identified Mail
    /// (DKIM) during the predictive inbox placement test.
    dkim_percentage: ?f64 = null,

    /// The percentage of emails that arrived in recipients' inboxes during the
    /// predictive inbox placement test.
    inbox_percentage: ?f64 = null,

    /// The percentage of emails that didn't arrive in recipients' inboxes at all
    /// during the
    /// predictive inbox placement test.
    missing_percentage: ?f64 = null,

    /// The percentage of emails that arrived in recipients' spam or junk mail
    /// folders during
    /// the predictive inbox placement test.
    spam_percentage: ?f64 = null,

    /// The percentage of emails that were authenticated by using Sender Policy
    /// Framework
    /// (SPF) during the predictive inbox placement test.
    spf_percentage: ?f64 = null,

    pub const json_field_names = .{
        .dkim_percentage = "DkimPercentage",
        .inbox_percentage = "InboxPercentage",
        .missing_percentage = "MissingPercentage",
        .spam_percentage = "SpamPercentage",
        .spf_percentage = "SpfPercentage",
    };
};
