pub const DQStopJobOnFailureTiming = enum {
    immediate,
    after_data_load,

    pub const json_field_names = .{
        .immediate = "Immediate",
        .after_data_load = "AfterDataLoad",
    };
};
