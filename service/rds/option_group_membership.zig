/// Provides information on the option groups the DB instance is a member of.
pub const OptionGroupMembership = struct {
    /// The name of the option group that the instance belongs to.
    option_group_name: ?[]const u8 = null,

    /// The status of the DB instance's option group membership. Valid values are:
    /// `in-sync`, `pending-apply`, `pending-removal`, `pending-maintenance-apply`,
    /// `pending-maintenance-removal`, `applying`, `removing`, and `failed`.
    status: ?[]const u8 = null,
};
