const std = @import("std");

pub const LifecycleSupportName = enum {
    open_source_rds_standard_support,
    open_source_rds_extended_support,

    pub const json_field_names = .{
        .open_source_rds_standard_support = "open-source-rds-standard-support",
        .open_source_rds_extended_support = "open-source-rds-extended-support",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open_source_rds_standard_support => "open-source-rds-standard-support",
            .open_source_rds_extended_support => "open-source-rds-extended-support",
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
