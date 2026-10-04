const std = @import("std");

/// A tile layout for a multiview channel. Each layout determines how many
/// source tiles are composited into the output and how those tiles are
/// arranged.
///
/// The allowed values are:
///
/// * `LAYOUT_2EH` – Two tiles of equal size, arranged horizontally.
/// * `LAYOUT_2PL` – Two tiles, with one larger primary tile.
/// * `LAYOUT_3EL` – Three tiles of equal size, arranged in two columns.
/// * `LAYOUT_3PL` – Three tiles, with one larger primary tile on the left and
///   two stacked on the right.
/// * `LAYOUT_4E` – Four tiles of equal size, arranged in a two-by-two grid.
/// * `LAYOUT_4PL` – Four tiles, with one larger primary tile on the left and
///   three stacked on the right.
pub const MultiviewLayoutType = enum {
    layout_2_eh,
    layout_2_pl,
    layout_3_el,
    layout_3_pl,
    layout_4_e,
    layout_4_pl,

    pub const json_field_names = .{
        .layout_2_eh = "LAYOUT_2EH",
        .layout_2_pl = "LAYOUT_2PL",
        .layout_3_el = "LAYOUT_3EL",
        .layout_3_pl = "LAYOUT_3PL",
        .layout_4_e = "LAYOUT_4E",
        .layout_4_pl = "LAYOUT_4PL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .layout_2_eh => "LAYOUT_2EH",
            .layout_2_pl => "LAYOUT_2PL",
            .layout_3_el => "LAYOUT_3EL",
            .layout_3_pl => "LAYOUT_3PL",
            .layout_4_e => "LAYOUT_4E",
            .layout_4_pl => "LAYOUT_4PL",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
