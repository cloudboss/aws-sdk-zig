const std = @import("std");

/// Set ID3 metadata to Passthrough to include ID3 metadata in this output. This
/// includes ID3 metadata from the following features: ID3 timestamp period, and
/// Custom ID3 metadata inserter. To exclude this ID3 metadata in this output:
/// set ID3 metadata to None or leave blank.
pub const TimedMetadata = enum {
    passthrough,
    none,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .none => "NONE",
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
