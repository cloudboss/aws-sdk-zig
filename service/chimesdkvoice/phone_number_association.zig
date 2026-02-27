const PhoneNumberAssociationName = @import("phone_number_association_name.zig").PhoneNumberAssociationName;

/// The phone number associations, such as an Amazon Chime SDK account ID, user
/// ID,
/// Voice Connector ID, or Voice Connector group ID.
pub const PhoneNumberAssociation = struct {
    /// The timestamp of the phone number association, in ISO 8601 format.
    associated_timestamp: ?i64,

    /// Defines the association with an Amazon Chime SDK account ID, user ID, Voice
    /// Connector ID, or Voice Connector group ID.
    name: ?PhoneNumberAssociationName,

    /// Contains the ID for the entity specified in Name.
    value: ?[]const u8,

    pub const json_field_names = .{
        .associated_timestamp = "AssociatedTimestamp",
        .name = "Name",
        .value = "Value",
    };
};
