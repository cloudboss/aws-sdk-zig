const ContactListDestination = @import("contact_list_destination.zig").ContactListDestination;
const SuppressionListDestination = @import("suppression_list_destination.zig").SuppressionListDestination;

/// An object that contains details about the resource destination the import
/// job is going
/// to target.
pub const ImportDestination = struct {
    /// An object that contains the action of the import job towards a contact list.
    contact_list_destination: ?ContactListDestination,

    /// An object that contains the action of the import job towards suppression
    /// list.
    suppression_list_destination: ?SuppressionListDestination,

    pub const json_field_names = .{
        .contact_list_destination = "ContactListDestination",
        .suppression_list_destination = "SuppressionListDestination",
    };
};
