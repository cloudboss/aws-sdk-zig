const ResaleAuthorizationResellerRoleString = @import("resale_authorization_reseller_role_string.zig").ResaleAuthorizationResellerRoleString;

/// Allows filtering on the `ResellerRole` of a ResaleAuthorization.
pub const ResaleAuthorizationResellerRoleFilter = struct {
    /// Allows filtering on the `ResellerRole` of a ResaleAuthorization with list
    /// input.
    value_list: ?[]const ResaleAuthorizationResellerRoleString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
