const std = @import("std");

/// The engine mode for the domain. Valid values are `GENERAL` (the standard
/// OpenSearch engine) and `OPTIMIZED`. If you don't specify an engine mode,
/// `GENERAL` is used. `OPTIMIZED` requires OpenSearch 3.5 or later,
/// OpenSearch Optimized instance types (OR1, OR2, OM2, or OI2) for the data
/// tier,
/// and is available only for the `OBSERVABILITY` use cases. The engine mode
/// can't be changed after the domain is created.
pub const EngineMode = enum {
    general,
    optimized,

    pub const json_field_names = .{
        .general = "GENERAL",
        .optimized = "OPTIMIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .general => "GENERAL",
            .optimized => "OPTIMIZED",
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
