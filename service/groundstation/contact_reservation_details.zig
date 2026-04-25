/// Details of a contact reservation.
pub const ContactReservationDetails = struct {
    /// UUID of a contact.
    contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_id = "contactId",
    };
};
