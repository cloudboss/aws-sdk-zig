const std = @import("std");

/// The value type of the parameter. The value type is used to validate the
/// parameter before it is evaluated.
pub const DatasetParameterValueType = enum {
    multi_valued,
    single_valued,

    pub const json_field_names = .{
        .multi_valued = "MULTI_VALUED",
        .single_valued = "SINGLE_VALUED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_valued => "MULTI_VALUED",
            .single_valued => "SINGLE_VALUED",
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
