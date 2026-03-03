const std = @import("std");

/// Dvb Dash Accessibility
pub const DvbDashAccessibility = enum {
    dvbdash_1_visually_impaired,
    dvbdash_2_hard_of_hearing,
    dvbdash_3_supplemental_commentary,
    dvbdash_4_directors_commentary,
    dvbdash_5_educational_notes,
    dvbdash_6_main_program,
    dvbdash_7_clean_feed,

    pub const json_field_names = .{
        .dvbdash_1_visually_impaired = "DVBDASH_1_VISUALLY_IMPAIRED",
        .dvbdash_2_hard_of_hearing = "DVBDASH_2_HARD_OF_HEARING",
        .dvbdash_3_supplemental_commentary = "DVBDASH_3_SUPPLEMENTAL_COMMENTARY",
        .dvbdash_4_directors_commentary = "DVBDASH_4_DIRECTORS_COMMENTARY",
        .dvbdash_5_educational_notes = "DVBDASH_5_EDUCATIONAL_NOTES",
        .dvbdash_6_main_program = "DVBDASH_6_MAIN_PROGRAM",
        .dvbdash_7_clean_feed = "DVBDASH_7_CLEAN_FEED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dvbdash_1_visually_impaired => "DVBDASH_1_VISUALLY_IMPAIRED",
            .dvbdash_2_hard_of_hearing => "DVBDASH_2_HARD_OF_HEARING",
            .dvbdash_3_supplemental_commentary => "DVBDASH_3_SUPPLEMENTAL_COMMENTARY",
            .dvbdash_4_directors_commentary => "DVBDASH_4_DIRECTORS_COMMENTARY",
            .dvbdash_5_educational_notes => "DVBDASH_5_EDUCATIONAL_NOTES",
            .dvbdash_6_main_program => "DVBDASH_6_MAIN_PROGRAM",
            .dvbdash_7_clean_feed => "DVBDASH_7_CLEAN_FEED",
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
