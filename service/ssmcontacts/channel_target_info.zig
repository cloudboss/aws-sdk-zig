/// Information about the contact channel that Incident Manager uses to engage
/// the
/// contact.
pub const ChannelTargetInfo = struct {
    /// The Amazon Resource Name (ARN) of the contact channel.
    contact_channel_id: []const u8,

    /// The number of minutes to wait before retrying to send engagement if the
    /// engagement
    /// initially failed.
    retry_interval_in_minutes: ?i32,

    pub const json_field_names = .{
        .contact_channel_id = "ContactChannelId",
        .retry_interval_in_minutes = "RetryIntervalInMinutes",
    };
};
