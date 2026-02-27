const aws = @import("aws");

const Address = @import("address.zig").Address;
const Email = @import("email.zig").Email;
const ExternalId = @import("external_id.zig").ExternalId;
const Name = @import("name.zig").Name;
const PhoneNumber = @import("phone_number.zig").PhoneNumber;
const Photo = @import("photo.zig").Photo;
const Role = @import("role.zig").Role;
const UserStatus = @import("user_status.zig").UserStatus;

/// A user object that contains the metadata and attributes for a specified
/// user.
pub const User = struct {
    /// A list of `Address` objects containing addresses associated with the user.
    addresses: ?[]const Address,

    /// The user's birthdate in YYYY-MM-DD format. This field stores personal
    /// birthdate information for the user.
    birthdate: ?[]const u8,

    /// The date and time the user was created.
    created_at: ?i64,

    /// The identifier of the user or system that created the user.
    created_by: ?[]const u8,

    /// A string containing the name of the user that is formatted for display when
    /// the user is referenced. For example, "John Doe."
    ///
    /// Prefix search supports a maximum of 1,000 characters for the string.
    display_name: ?[]const u8,

    /// A list of `Email` objects containing email addresses associated with the
    /// user.
    emails: ?[]const Email,

    /// A map of explicitly requested attribute extensions associated with the user.
    /// Not populated if the user has no requested extensions.
    extensions: ?[]const aws.map.StringMapEntry,

    /// A list of `ExternalId` objects that contains the identifiers issued to this
    /// resource by an external identity provider.
    external_ids: ?[]const ExternalId,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// A string containing the geographical region or location of the user.
    locale: ?[]const u8,

    /// An object containing the name of the user.
    name: ?Name,

    /// A string containing an alternate name for the user.
    nick_name: ?[]const u8,

    /// A list of `PhoneNumber` objects containing phone numbers associated with the
    /// user.
    phone_numbers: ?[]const PhoneNumber,

    /// A list of photos associated with the user. Users can have up to 3 photos
    /// with metadata including type, display name, and primary designation.
    photos: ?[]const Photo,

    /// A string containing the preferred language of the user. For example,
    /// "American English" or "en-us."
    preferred_language: ?[]const u8,

    /// A string containing a URL that might be associated with the user.
    profile_url: ?[]const u8,

    /// A list of `Role` objects containing roles associated with the user.
    roles: ?[]const Role,

    /// A string containing the time zone of the user.
    timezone: ?[]const u8,

    /// A string containing the title of the user. Possible values are left
    /// unspecified. The value can vary based on your specific use case.
    title: ?[]const u8,

    /// The date and time the user was last updated.
    updated_at: ?i64,

    /// The identifier of the user or system that last updated the user.
    updated_by: ?[]const u8,

    /// The identifier for a user in the identity store.
    user_id: []const u8,

    /// A unique string used to identify the user. The length limit is 128
    /// characters. This value can consist of letters, accented characters, symbols,
    /// numbers, and punctuation. This value is specified at the time the user is
    /// created and stored as an attribute of the user object in the identity store.
    user_name: ?[]const u8,

    /// The current status of the user account.
    user_status: ?UserStatus,

    /// A string indicating the type of user. Possible values are left unspecified.
    /// The value can vary based on your specific use case.
    user_type: ?[]const u8,

    /// The user's personal website or blog URL. This field stores website
    /// information for personal or professional use.
    website: ?[]const u8,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .birthdate = "Birthdate",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .display_name = "DisplayName",
        .emails = "Emails",
        .extensions = "Extensions",
        .external_ids = "ExternalIds",
        .identity_store_id = "IdentityStoreId",
        .locale = "Locale",
        .name = "Name",
        .nick_name = "NickName",
        .phone_numbers = "PhoneNumbers",
        .photos = "Photos",
        .preferred_language = "PreferredLanguage",
        .profile_url = "ProfileUrl",
        .roles = "Roles",
        .timezone = "Timezone",
        .title = "Title",
        .updated_at = "UpdatedAt",
        .updated_by = "UpdatedBy",
        .user_id = "UserId",
        .user_name = "UserName",
        .user_status = "UserStatus",
        .user_type = "UserType",
        .website = "Website",
    };
};
