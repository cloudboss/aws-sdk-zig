pub const PowerFeedDrop = enum {
    above_rack,
    below_rack,

    pub const json_field_names = .{
        .above_rack = "ABOVE_RACK",
        .below_rack = "BELOW_RACK",
    };
};
