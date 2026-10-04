const std = @import("std");

/// The types of manifest that you want Amazon Web Services to create for this
/// report.
pub const AdditionalArtifact = enum {
    redshift,
    quicksight,
    athena,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
        .quicksight = "QUICKSIGHT",
        .athena = "ATHENA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .redshift => "REDSHIFT",
            .quicksight => "QUICKSIGHT",
            .athena => "ATHENA",
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
