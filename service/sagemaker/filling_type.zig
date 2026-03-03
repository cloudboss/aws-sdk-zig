const std = @import("std");

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
        .frontfill = "frontfill",
        .middlefill = "middlefill",
        .backfill = "backfill",
        .futurefill = "futurefill",
        .frontfill_value = "frontfill_value",
        .middlefill_value = "middlefill_value",
        .backfill_value = "backfill_value",
        .futurefill_value = "futurefill_value",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .frontfill => "frontfill",
            .middlefill => "middlefill",
            .backfill => "backfill",
            .futurefill => "futurefill",
            .frontfill_value => "frontfill_value",
            .middlefill_value => "middlefill_value",
            .backfill_value => "backfill_value",
            .futurefill_value => "futurefill_value",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
