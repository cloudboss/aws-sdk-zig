const PhoneNumberAssociationName = @import("phone_number_association_name.zig").PhoneNumberAssociationName;

/// The phone number associations, such as Amazon Chime account ID, Amazon Chime
/// user ID, Amazon
/// Chime Voice Connector ID, or Amazon Chime Voice Connector group ID.
pub const PhoneNumberAssociation = struct {
    /// The timestamp of the phone number association, in ISO 8601 format.
    associated_timestamp: ?i64 = null,

    /// Defines the association with an Amazon Chime account ID, user ID, Amazon
    /// Chime Voice Connector
    /// ID, or Amazon Chime Voice Connector group ID.
    name: ?PhoneNumberAssociationName = null,

    /// Contains the ID for the entity specified in Name.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_timestamp = "AssociatedTimestamp",
        .name = "Name",
        .value = "Value",
    };
};
