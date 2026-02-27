/// Allows filtering on the `OfferExtendedStatus` of a ResaleAuthorization.
pub const ResaleAuthorizationOfferExtendedStatusFilter = struct {
    /// Allows filtering on the `OfferExtendedStatus` of a ResaleAuthorization with
    /// list input.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
