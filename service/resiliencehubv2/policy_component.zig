const std = @import("std");

pub const PolicyComponent = enum {
    availability_slo,
    multi_az_disaster_recovery,
    multi_region_disaster_recovery,
    data_recovery,

    pub const json_field_names = .{
        .availability_slo = "AVAILABILITY_SLO",
        .multi_az_disaster_recovery = "MULTI_AZ_DISASTER_RECOVERY",
        .multi_region_disaster_recovery = "MULTI_REGION_DISASTER_RECOVERY",
        .data_recovery = "DATA_RECOVERY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .availability_slo => "AVAILABILITY_SLO",
            .multi_az_disaster_recovery => "MULTI_AZ_DISASTER_RECOVERY",
            .multi_region_disaster_recovery => "MULTI_REGION_DISASTER_RECOVERY",
            .data_recovery => "DATA_RECOVERY",
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
