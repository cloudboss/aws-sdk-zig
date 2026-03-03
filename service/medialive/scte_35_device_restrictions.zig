const std = @import("std");

/// Corresponds to the device_restrictions parameter in a
/// segmentation_descriptor. If you include one of the "restriction" flags then
/// you must include all four of them.
pub const Scte35DeviceRestrictions = enum {
    none,
    restrict_group0,
    restrict_group1,
    restrict_group2,

    pub const json_field_names = .{
        .none = "NONE",
        .restrict_group0 = "RESTRICT_GROUP0",
        .restrict_group1 = "RESTRICT_GROUP1",
        .restrict_group2 = "RESTRICT_GROUP2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .restrict_group0 => "RESTRICT_GROUP0",
            .restrict_group1 => "RESTRICT_GROUP1",
            .restrict_group2 => "RESTRICT_GROUP2",
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
