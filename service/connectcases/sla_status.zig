pub const SlaStatus = enum {
    active,
    overdue,
    met,
    not_met,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .overdue = "OVERDUE",
        .met = "MET",
        .not_met = "NOT_MET",
    };
};
