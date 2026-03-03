const ActivationStatus = @import("activation_status.zig").ActivationStatus;
const ContactChannelAddress = @import("contact_channel_address.zig").ContactChannelAddress;
const ChannelType = @import("channel_type.zig").ChannelType;

/// The method that Incident Manager uses to engage a contact.
pub const ContactChannel = struct {
    /// A Boolean value describing if the contact channel has been activated or not.
    /// If the
    /// contact channel isn't activated, Incident Manager can't engage the contact
    /// through it.
    activation_status: ActivationStatus,

    /// The ARN of the contact that contains the contact channel.
    contact_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the contact channel.
    contact_channel_arn: []const u8,

    /// The details that Incident Manager uses when trying to engage the contact
    /// channel.
    delivery_address: ContactChannelAddress,

    /// The name of the contact channel.
    name: []const u8,

    /// The type of the contact channel. Incident Manager supports three contact
    /// methods:
    ///
    /// * SMS
    ///
    /// * VOICE
    ///
    /// * EMAIL
    @"type": ?ChannelType = null,

    pub const json_field_names = .{
        .activation_status = "ActivationStatus",
        .contact_arn = "ContactArn",
        .contact_channel_arn = "ContactChannelArn",
        .delivery_address = "DeliveryAddress",
        .name = "Name",
        .@"type" = "Type",
    };
};
