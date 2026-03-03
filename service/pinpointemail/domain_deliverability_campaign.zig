/// An object that contains the deliverability data for a specific campaign.
/// This data is
/// available for a campaign only if the campaign sent email by using a domain
/// that the
/// Deliverability dashboard is enabled for (`PutDeliverabilityDashboardOption`
/// operation).
pub const DomainDeliverabilityCampaign = struct {
    /// The unique identifier for the campaign. Amazon Pinpoint automatically
    /// generates and assigns this
    /// identifier to a campaign. This value is not the same as the campaign
    /// identifier that
    /// Amazon Pinpoint assigns to campaigns that you create and manage by using the
    /// Amazon Pinpoint API or the
    /// Amazon Pinpoint console.
    campaign_id: ?[]const u8 = null,

    /// The percentage of email messages that were deleted by recipients, without
    /// being opened
    /// first. Due to technical limitations, this value only includes recipients who
    /// opened the
    /// message by using an email client that supports images.
    delete_rate: ?f64 = null,

    /// The major email providers who handled the email message.
    esps: ?[]const []const u8 = null,

    /// The first time, in Unix time format, when the email message was delivered to
    /// any
    /// recipient's inbox. This value can help you determine how long it took for a
    /// campaign to
    /// deliver an email message.
    first_seen_date_time: ?i64 = null,

    /// The verified email address that the email message was sent from.
    from_address: ?[]const u8 = null,

    /// The URL of an image that contains a snapshot of the email message that was
    /// sent.
    image_url: ?[]const u8 = null,

    /// The number of email messages that were delivered to recipients’ inboxes.
    inbox_count: ?i64 = null,

    /// The last time, in Unix time format, when the email message was delivered to
    /// any
    /// recipient's inbox. This value can help you determine how long it took for a
    /// campaign to
    /// deliver an email message.
    last_seen_date_time: ?i64 = null,

    /// The projected number of recipients that the email message was sent to.
    projected_volume: ?i64 = null,

    /// The percentage of email messages that were opened and then deleted by
    /// recipients. Due
    /// to technical limitations, this value only includes recipients who opened the
    /// message by
    /// using an email client that supports images.
    read_delete_rate: ?f64 = null,

    /// The percentage of email messages that were opened by recipients. Due to
    /// technical
    /// limitations, this value only includes recipients who opened the message by
    /// using an
    /// email client that supports images.
    read_rate: ?f64 = null,

    /// The IP addresses that were used to send the email message.
    sending_ips: ?[]const []const u8 = null,

    /// The number of email messages that were delivered to recipients' spam or junk
    /// mail
    /// folders.
    spam_count: ?i64 = null,

    /// The subject line, or title, of the email message.
    subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .campaign_id = "CampaignId",
        .delete_rate = "DeleteRate",
        .esps = "Esps",
        .first_seen_date_time = "FirstSeenDateTime",
        .from_address = "FromAddress",
        .image_url = "ImageUrl",
        .inbox_count = "InboxCount",
        .last_seen_date_time = "LastSeenDateTime",
        .projected_volume = "ProjectedVolume",
        .read_delete_rate = "ReadDeleteRate",
        .read_rate = "ReadRate",
        .sending_ips = "SendingIps",
        .spam_count = "SpamCount",
        .subject = "Subject",
    };
};
