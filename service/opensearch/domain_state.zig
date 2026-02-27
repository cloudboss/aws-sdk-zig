pub const DomainState = enum {
    active,
    processing,
    not_available,

    pub const json_field_names = .{
        .active = "Active",
        .processing = "Processing",
        .not_available = "NotAvailable",
    };
};
