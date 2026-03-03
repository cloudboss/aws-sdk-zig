/// The outbound email address ID.
pub const OutboundEmailConfig = struct {
    /// The identifier of the email address.
    outbound_email_address_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .outbound_email_address_id = "OutboundEmailAddressId",
    };
};
