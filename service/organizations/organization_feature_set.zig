const std = @import("std");

pub const OrganizationFeatureSet = enum {
    all,
    consolidated_billing,

    pub const json_field_names = .{
        .all = "ALL",
        .consolidated_billing = "CONSOLIDATED_BILLING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .consolidated_billing => "CONSOLIDATED_BILLING",
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
