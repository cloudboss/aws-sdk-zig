const std = @import("std");

/// The output format of an export. `CSV` produces comma-separated rows.
/// `OCSF_JSON` produces newline-delimited JSON records in the Open
/// Cybersecurity Schema Framework (OCSF) format.
pub const FindingsExportFormat = enum {
    csv,
    ocsf_json,

    pub const json_field_names = .{
        .csv = "CSV",
        .ocsf_json = "OCSF_JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .csv => "CSV",
            .ocsf_json => "OCSF_JSON",
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
