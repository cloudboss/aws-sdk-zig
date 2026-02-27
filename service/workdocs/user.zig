const LocaleType = @import("locale_type.zig").LocaleType;
const UserStatusType = @import("user_status_type.zig").UserStatusType;
const UserStorageMetadata = @import("user_storage_metadata.zig").UserStorageMetadata;
const UserType = @import("user_type.zig").UserType;

/// Describes a user.
pub const User = struct {
    /// The time when the user was created.
    created_timestamp: ?i64,

    /// The email address of the user.
    email_address: ?[]const u8,

    /// The given name of the user.
    given_name: ?[]const u8,

    /// The ID of the user.
    id: ?[]const u8,

    /// The locale of the user.
    locale: ?LocaleType,

    /// The time when the user was modified.
    modified_timestamp: ?i64,

    /// The ID of the organization.
    organization_id: ?[]const u8,

    /// The ID of the recycle bin folder.
    recycle_bin_folder_id: ?[]const u8,

    /// The ID of the root folder.
    root_folder_id: ?[]const u8,

    /// The status of the user.
    status: ?UserStatusType,

    /// The storage for the user.
    storage: ?UserStorageMetadata,

    /// The surname of the user.
    surname: ?[]const u8,

    /// The time zone ID of the user.
    time_zone_id: ?[]const u8,

    /// The type of user.
    type: ?UserType,

    /// The login name of the user.
    username: ?[]const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .email_address = "EmailAddress",
        .given_name = "GivenName",
        .id = "Id",
        .locale = "Locale",
        .modified_timestamp = "ModifiedTimestamp",
        .organization_id = "OrganizationId",
        .recycle_bin_folder_id = "RecycleBinFolderId",
        .root_folder_id = "RootFolderId",
        .status = "Status",
        .storage = "Storage",
        .surname = "Surname",
        .time_zone_id = "TimeZoneId",
        .type = "Type",
        .username = "Username",
    };
};
