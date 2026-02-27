const ContactListImportAction = @import("contact_list_import_action.zig").ContactListImportAction;

/// An object that contains details about the action of a contact list.
pub const ContactListDestination = struct {
    /// >The type of action to perform on the addresses. The following are the
    /// possible
    /// values:
    ///
    /// * PUT: add the addresses to the contact list. If the record already exists,
    ///   it
    /// will override it with the new value.
    ///
    /// * DELETE: remove the addresses from the contact list.
    contact_list_import_action: ContactListImportAction,

    /// The name of the contact list.
    contact_list_name: []const u8,

    pub const json_field_names = .{
        .contact_list_import_action = "ContactListImportAction",
        .contact_list_name = "ContactListName",
    };
};
