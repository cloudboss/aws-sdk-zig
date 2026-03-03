/// Request for which contact was successfully created.
pub const SuccessfulRequest = struct {
    /// The contactId of the contact that was created successfully.
    contact_id: ?[]const u8 = null,

    /// Request identifier provided in the API call in the ContactDataRequest to
    /// create a contact.
    request_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .request_identifier = "RequestIdentifier",
    };
};
