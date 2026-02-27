/// Units for duration, e.g. 'MONTHS'
pub const OfferingDurationUnits = enum {
    months,

    pub const json_field_names = .{
        .months = "MONTHS",
    };
};
