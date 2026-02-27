/// Details about an override action for a rule.
pub const WafOverrideAction = struct {
    /// `COUNT` overrides the action specified by the individual rule within a
    /// `RuleGroup` .
    ///
    /// If set to `NONE`, the rule's action takes place.
    type: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
    };
};
