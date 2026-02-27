const UserIdentityType = @import("user_identity_type.zig").UserIdentityType;

/// Description of the requester that calls the API operation.
pub const UserIdentity = struct {
    /// A unique identifier for the requester that calls the API operation.
    principal_id: ?[]const u8,

    /// The identity type of the requester that calls the API operation.
    type: ?UserIdentityType,

    pub const json_field_names = .{
        .principal_id = "PrincipalId",
        .type = "Type",
    };
};
