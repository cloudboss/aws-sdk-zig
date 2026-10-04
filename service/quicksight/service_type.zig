const std = @import("std");

pub const ServiceType = enum {
    redshift,
    qbusiness,
    athena,
    glue_data_catalog,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
        .qbusiness = "QBUSINESS",
        .athena = "ATHENA",
        .glue_data_catalog = "GLUE_DATA_CATALOG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .redshift => "REDSHIFT",
            .qbusiness => "QBUSINESS",
            .athena => "ATHENA",
            .glue_data_catalog => "GLUE_DATA_CATALOG",
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
