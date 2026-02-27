pub const FillingType = enum {
    frontfill,
    middlefill,
    backfill,
    futurefill,
    frontfill_value,
    middlefill_value,
    backfill_value,
    futurefill_value,

    pub const json_field_names = .{
        .frontfill = "Frontfill",
        .middlefill = "Middlefill",
        .backfill = "Backfill",
        .futurefill = "Futurefill",
        .frontfill_value = "FrontfillValue",
        .middlefill_value = "MiddlefillValue",
        .backfill_value = "BackfillValue",
        .futurefill_value = "FuturefillValue",
    };
};
