/// The target account, organizational unit, or the root that is associated with
/// an Security Hub configuration. The configuration
/// can be a configuration policy or self-managed behavior.
pub const Target = union(enum) {
    /// The Amazon Web Services account ID of the target account.
    account_id: ?[]const u8,
    /// The organizational unit ID of the target organizational unit.
    organizational_unit_id: ?[]const u8,
    /// The ID of the organization root.
    root_id: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .organizational_unit_id = "OrganizationalUnitId",
        .root_id = "RootId",
    };
};
