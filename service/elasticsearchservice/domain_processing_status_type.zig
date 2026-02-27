pub const DomainProcessingStatusType = enum {
    creating,
    active,
    modifying,
    upgrading,
    updating,
    isolated,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .modifying = "MODIFYING",
        .upgrading = "UPGRADING",
        .updating = "UPDATING",
        .isolated = "ISOLATED",
        .deleting = "DELETING",
    };
};
