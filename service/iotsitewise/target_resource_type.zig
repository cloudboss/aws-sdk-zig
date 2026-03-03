const std = @import("std");

pub const TargetResourceType = enum {
    asset,
    computation_model,

    pub const json_field_names = .{
        .asset = "ASSET",
        .computation_model = "COMPUTATION_MODEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asset => "ASSET",
            .computation_model => "COMPUTATION_MODEL",
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
