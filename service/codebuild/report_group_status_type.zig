pub const ReportGroupStatusType = enum {
    active,
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
    };
};
