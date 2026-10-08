const std = @import("std");

/// The operator that a label selector requirement applies to its key and
/// values.
///
/// * IN — the key's value must be one of the specified values.
/// * NOT_IN — the key's value must not be one of the specified values.
/// * EXISTS — the key must be present, regardless of its value.
/// * DOES_NOT_EXIST — the key must not be present.
pub const EksLabelSelectorOperator = enum {
    in,
    not_in,
    exists,
    does_not_exist,

    pub const json_field_names = .{
        .in = "IN",
        .not_in = "NOT_IN",
        .exists = "EXISTS",
        .does_not_exist = "DOES_NOT_EXIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in => "IN",
            .not_in => "NOT_IN",
            .exists => "EXISTS",
            .does_not_exist => "DOES_NOT_EXIST",
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
