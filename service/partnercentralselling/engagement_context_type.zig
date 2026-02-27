pub const EngagementContextType = enum {
    customer_project,
    lead,

    pub const json_field_names = .{
        .customer_project = "CUSTOMER_PROJECT",
        .lead = "LEAD",
    };
};
