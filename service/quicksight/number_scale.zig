const std = @import("std");

pub const NumberScale = enum {
    none,
    auto,
    thousands,
    millions,
    billions,
    trillions,
    lakhs,
    crores,

    pub const json_field_names = .{
        .none = "NONE",
        .auto = "AUTO",
        .thousands = "THOUSANDS",
        .millions = "MILLIONS",
        .billions = "BILLIONS",
        .trillions = "TRILLIONS",
        .lakhs = "LAKHS",
        .crores = "CRORES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .auto => "AUTO",
            .thousands => "THOUSANDS",
            .millions => "MILLIONS",
            .billions => "BILLIONS",
            .trillions => "TRILLIONS",
            .lakhs => "LAKHS",
            .crores => "CRORES",
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
