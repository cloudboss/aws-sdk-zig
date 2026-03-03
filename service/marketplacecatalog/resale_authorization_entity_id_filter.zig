/// Allows filtering on `EntityId` of a ResaleAuthorization.
pub const ResaleAuthorizationEntityIdFilter = struct {
    /// Allows filtering on `EntityId` of a ResaleAuthorization with list input.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
