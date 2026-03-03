const std = @import("std");

/// The category of the finding. Possible values are:
pub const FindingCategory = enum {
    classification,
    policy,

    pub const json_field_names = .{
        .classification = "CLASSIFICATION",
        .policy = "POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .classification => "CLASSIFICATION",
            .policy => "POLICY",
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
