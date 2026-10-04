const std = @import("std");

/// Nielsen Watermarks Distribution Types
pub const NielsenWatermarksDistributionTypes = enum {
    final_distributor,
    program_content,

    pub const json_field_names = .{
        .final_distributor = "FINAL_DISTRIBUTOR",
        .program_content = "PROGRAM_CONTENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .final_distributor => "FINAL_DISTRIBUTOR",
            .program_content => "PROGRAM_CONTENT",
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
