const AlexaForBusinessMetadata = @import("alexa_for_business_metadata.zig").AlexaForBusinessMetadata;
const License = @import("license.zig").License;
const UserType = @import("user_type.zig").UserType;

/// The user ID and user fields to update, used with the
/// BatchUpdateUser action.
pub const UpdateUserRequestItem = struct {
    /// The Alexa for Business metadata.
    alexa_for_business_metadata: ?AlexaForBusinessMetadata,

    /// The user license type.
    license_type: ?License,

    /// The user ID.
    user_id: []const u8,

    /// The user type.
    user_type: ?UserType,

    pub const json_field_names = .{
        .alexa_for_business_metadata = "AlexaForBusinessMetadata",
        .license_type = "LicenseType",
        .user_id = "UserId",
        .user_type = "UserType",
    };
};
