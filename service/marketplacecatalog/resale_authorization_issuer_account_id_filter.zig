/// Allows filtering on the `IssuerAccountId` of a ResaleAuthorization.
pub const ResaleAuthorizationIssuerAccountIdFilter = struct {
    /// Allows filtering on the `IssuerAccountId` of a ResaleAuthorization with list
    /// input.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
