const std = @import("std");

pub const DbInstanceType = enum {
    db_influx_medium,
    db_influx_large,
    db_influx_xlarge,
    db_influx_2_xlarge,
    db_influx_4_xlarge,
    db_influx_8_xlarge,
    db_influx_12_xlarge,
    db_influx_16_xlarge,
    db_influx_24_xlarge,

    pub const json_field_names = .{
        .db_influx_medium = "db.influx.medium",
        .db_influx_large = "db.influx.large",
        .db_influx_xlarge = "db.influx.xlarge",
        .db_influx_2_xlarge = "db.influx.2xlarge",
        .db_influx_4_xlarge = "db.influx.4xlarge",
        .db_influx_8_xlarge = "db.influx.8xlarge",
        .db_influx_12_xlarge = "db.influx.12xlarge",
        .db_influx_16_xlarge = "db.influx.16xlarge",
        .db_influx_24_xlarge = "db.influx.24xlarge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .db_influx_medium => "db.influx.medium",
            .db_influx_large => "db.influx.large",
            .db_influx_xlarge => "db.influx.xlarge",
            .db_influx_2_xlarge => "db.influx.2xlarge",
            .db_influx_4_xlarge => "db.influx.4xlarge",
            .db_influx_8_xlarge => "db.influx.8xlarge",
            .db_influx_12_xlarge => "db.influx.12xlarge",
            .db_influx_16_xlarge => "db.influx.16xlarge",
            .db_influx_24_xlarge => "db.influx.24xlarge",
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
