pub const DomainHealth = enum {
    red,
    yellow,
    green,
    not_available,

    pub const json_field_names = .{
        .red = "Red",
        .yellow = "Yellow",
        .green = "Green",
        .not_available = "NotAvailable",
    };
};
