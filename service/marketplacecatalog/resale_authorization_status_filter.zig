const ResaleAuthorizationStatusString = @import("resale_authorization_status_string.zig").ResaleAuthorizationStatusString;

/// Allows filtering on the `Status` of a ResaleAuthorization.
pub const ResaleAuthorizationStatusFilter = struct {
    /// Allows filtering on the `Status` of a ResaleAuthorization with list input.
    value_list: ?[]const ResaleAuthorizationStatusString,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
