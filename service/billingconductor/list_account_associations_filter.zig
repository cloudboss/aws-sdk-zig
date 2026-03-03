/// The filter on the account ID of the linked account, or any of the following:
///
/// `MONITORED`: linked accounts that are associated to billing groups.
///
/// `UNMONITORED`: linked accounts that are not associated to billing groups.
///
/// `Billing Group Arn`: linked accounts that are associated to the provided
/// Billing Group Arn.
pub const ListAccountAssociationsFilter = struct {
    /// The Amazon Web Services account ID to filter on.
    account_id: ?[]const u8 = null,

    /// The list of Amazon Web Services IDs to retrieve their associated billing
    /// group for a given time range.
    account_ids: ?[]const []const u8 = null,

    /// `MONITORED`: linked accounts that are associated to billing groups.
    ///
    /// `UNMONITORED`: linked accounts that are not associated to billing groups.
    ///
    /// `Billing Group Arn`: linked accounts that are associated to the provided
    /// Billing Group Arn.
    association: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_ids = "AccountIds",
        .association = "Association",
    };
};
