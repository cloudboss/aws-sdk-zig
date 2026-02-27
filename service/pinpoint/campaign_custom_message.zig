/// Specifies the contents of a message that's sent through a custom channel to
/// recipients of a campaign.
pub const CampaignCustomMessage = struct {
    /// The raw, JSON-formatted string to use as the payload for the message. The
    /// maximum size is 5 KB.
    data: ?[]const u8,

    pub const json_field_names = .{
        .data = "Data",
    };
};
