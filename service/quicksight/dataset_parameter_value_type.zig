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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
