/// The details that Incident Manager uses when trying to engage the contact
/// channel.
pub const ContactChannelAddress = struct {
    /// The format is dependent on the type of the contact channel. The following
    /// are the
    /// expected formats:
    ///
    /// * SMS - '+' followed by the country code and phone number
    ///
    /// * VOICE - '+' followed by the country code and phone number
    ///
    /// * EMAIL - any standard email format
    simple_address: ?[]const u8,

    pub const json_field_names = .{
        .simple_address = "SimpleAddress",
    };
};
