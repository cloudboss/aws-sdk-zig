pub const FirewallRuleGroupAssociationStatus = enum {
    complete,
    deleting,
    updating,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .deleting = "DELETING",
        .updating = "UPDATING",
    };
};
