/// An object that contains information about the amount of email that was
/// delivered to
/// recipients.
pub const VolumeStatistics = struct {
    /// The total number of emails that arrived in recipients' inboxes.
    inbox_raw_count: ?i64,

    /// An estimate of the percentage of emails sent from the current domain that
    /// will arrive
    /// in recipients' inboxes.
    projected_inbox: ?i64,

    /// An estimate of the percentage of emails sent from the current domain that
    /// will arrive
    /// in recipients' spam or junk mail folders.
    projected_spam: ?i64,

    /// The total number of emails that arrived in recipients' spam or junk mail
    /// folders.
    spam_raw_count: ?i64,

    pub const json_field_names = .{
        .inbox_raw_count = "InboxRawCount",
        .projected_inbox = "ProjectedInbox",
        .projected_spam = "ProjectedSpam",
        .spam_raw_count = "SpamRawCount",
    };
};
