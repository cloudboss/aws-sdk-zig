const std = @import("std");

pub const FindingHistoryUpdateSourceType = enum {
    batch_update_findings,
    batch_import_findings,

    pub const json_field_names = .{
        .batch_update_findings = "BATCH_UPDATE_FINDINGS",
        .batch_import_findings = "BATCH_IMPORT_FINDINGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .batch_update_findings => "BATCH_UPDATE_FINDINGS",
            .batch_import_findings => "BATCH_IMPORT_FINDINGS",
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
