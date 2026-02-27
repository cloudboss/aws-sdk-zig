pub const EntryViolationReason = enum {
    missing_expected_entry,
    incorrect_entry_order,
    entry_conflict,

    pub const json_field_names = .{
        .missing_expected_entry = "MissingExpectedEntry",
        .incorrect_entry_order = "IncorrectEntryOrder",
        .entry_conflict = "EntryConflict",
    };
};
