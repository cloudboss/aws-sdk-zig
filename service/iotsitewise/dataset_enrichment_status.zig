const std = @import("std");

pub const DatasetEnrichmentStatus = enum {
    fully_enriched,
    partially_enriched,
    not_enriched,

    pub const json_field_names = .{
        .fully_enriched = "FULLY_ENRICHED",
        .partially_enriched = "PARTIALLY_ENRICHED",
        .not_enriched = "NOT_ENRICHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fully_enriched => "FULLY_ENRICHED",
            .partially_enriched => "PARTIALLY_ENRICHED",
            .not_enriched => "NOT_ENRICHED",
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
