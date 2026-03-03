const std = @import("std");

pub const GroupDefinitionType = enum {
    dimension,
    tag,
    cost_category,

    pub const json_field_names = .{
        .dimension = "DIMENSION",
        .tag = "TAG",
        .cost_category = "COST_CATEGORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dimension => "DIMENSION",
            .tag => "TAG",
            .cost_category => "COST_CATEGORY",
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
