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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
