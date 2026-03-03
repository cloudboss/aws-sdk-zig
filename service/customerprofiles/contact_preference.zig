const ContactType = @import("contact_type.zig").ContactType;

/// Object that defines users contact preference.
pub const ContactPreference = struct {
    /// The contact type used for engagement. For example: HomePhoneNumber,
    /// PersonalEmailAddress.
    contact_type: ?ContactType = null,

    /// A searchable, unique identifier of a customer profile.
    key_name: ?[]const u8 = null,

    /// The key value used to look up profile based off the keyName.
    key_value: ?[]const u8 = null,

    /// The unique identifier of a customer profile.
    profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_type = "ContactType",
        .key_name = "KeyName",
        .key_value = "KeyValue",
        .profile_id = "ProfileId",
    };
};
