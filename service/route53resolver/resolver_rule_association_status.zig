pub const ResolverRuleAssociationStatus = enum {
    creating,
    complete,
    deleting,
    failed,
    overridden,

    pub const json_field_names = .{
        .creating = "Creating",
        .complete = "Complete",
        .deleting = "Deleting",
        .failed = "Failed",
        .overridden = "Overridden",
    };
};
