const std = @import("std");

/// The sort order specified in a listing condition. Possible values include the
/// following:
///
/// * `asc` - Present the information in ascending order (from A-Z).
///
/// * `dsc` - Present the information in descending order (from Z-A).
pub const SortOrder = enum {
    asc,
    dsc,

    pub const json_field_names = .{
        .asc = "asc",
        .dsc = "dsc",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asc => "asc",
            .dsc => "dsc",
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
