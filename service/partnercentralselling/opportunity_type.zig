const std = @import("std");

pub const OpportunityType = enum {
    net_new_business,
    flat_renewal,
    expansion,

    pub const json_field_names = .{
        .net_new_business = "Net New Business",
        .flat_renewal = "Flat Renewal",
        .expansion = "Expansion",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .net_new_business => "Net New Business",
            .flat_renewal => "Flat Renewal",
            .expansion => "Expansion",
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
