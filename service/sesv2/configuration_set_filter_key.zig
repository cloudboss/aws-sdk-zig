const std = @import("std");

/// The filter key to use when listing configuration sets. This can be one of
/// the
/// following:
///
/// * `CONFIGURATION_SET_NAME_CONTAINS` – Filter by a substring of the
///   configuration set name.
pub const ConfigurationSetFilterKey = enum {
    configuration_set_name_contains,

    pub const json_field_names = .{
        .configuration_set_name_contains = "CONFIGURATION_SET_NAME_CONTAINS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configuration_set_name_contains => "CONFIGURATION_SET_NAME_CONTAINS",
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
