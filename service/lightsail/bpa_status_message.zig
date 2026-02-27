pub const BPAStatusMessage = enum {
    defaulted_for_slr_missing,
    sync_on_hold,
    defaulted_for_slr_missing_on_hold,
    unknown,

    pub const json_field_names = .{
        .defaulted_for_slr_missing = "DEFAULTED_FOR_SLR_MISSING",
        .sync_on_hold = "SYNC_ON_HOLD",
        .defaulted_for_slr_missing_on_hold = "DEFAULTED_FOR_SLR_MISSING_ON_HOLD",
        .unknown = "Unknown",
    };
};
