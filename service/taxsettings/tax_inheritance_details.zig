/// Tax inheritance information associated with the account.
pub const TaxInheritanceDetails = struct {
    /// Tax inheritance reason information associated with the account.
    inheritance_obtained_reason: ?[]const u8,

    /// Tax inheritance parent account information associated with the account.
    parent_entity_id: ?[]const u8,

    pub const json_field_names = .{
        .inheritance_obtained_reason = "inheritanceObtainedReason",
        .parent_entity_id = "parentEntityId",
    };
};
