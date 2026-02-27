/// Use Dolby Vision Mode to choose how the service will handle Dolby Vision
/// MaxCLL and MaxFALL properies.
pub const DolbyVisionLevel6Mode = enum {
    passthrough,
    recalculate,
    specify,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .recalculate = "RECALCULATE",
        .specify = "SPECIFY",
    };
};
