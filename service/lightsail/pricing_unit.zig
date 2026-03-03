const std = @import("std");

pub const PricingUnit = enum {
    gb,
    hrs,
    gb_mo,
    bundles,
    queries,

    pub const json_field_names = .{
        .gb = "GB",
        .hrs = "Hrs",
        .gb_mo = "GB-Mo",
        .bundles = "Bundles",
        .queries = "Queries",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gb => "GB",
            .hrs => "Hrs",
            .gb_mo => "GB-Mo",
            .bundles => "Bundles",
            .queries => "Queries",
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
