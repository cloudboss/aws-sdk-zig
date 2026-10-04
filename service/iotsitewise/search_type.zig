const std = @import("std");

/// The search strategy, which trades off latency against recall. `DEEP` runs
/// the full semantic and
/// structured search for the highest-quality matches; `QUICK` returns faster,
/// lower-recall results.
/// When `searchType` is omitted on a request, the search defaults to `QUICK`.
pub const SearchType = enum {
    deep,
    quick,

    pub const json_field_names = .{
        .deep = "DEEP",
        .quick = "QUICK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deep => "DEEP",
            .quick => "QUICK",
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
