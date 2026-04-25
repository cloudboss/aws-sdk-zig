/// Summary information about an email address associated with a queue. Contains
/// the essential details needed to identify and manage the email address
/// routing configuration.
pub const EmailAddressSummary = struct {
    /// The Amazon Resource Name (ARN) of the email address associated with the
    /// queue.
    arn: ?[]const u8 = null,

    /// The unique identifier of the email address associated with the queue.
    id: ?[]const u8 = null,

    /// Indicates whether this email address is configured as the default outbound
    /// email address for the queue. When set to true, this email address is used as
    /// the default sender for outbound email contacts from this queue.
    is_default_outbound_email: bool = false,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .is_default_outbound_email = "IsDefaultOutboundEmail",
    };
};
