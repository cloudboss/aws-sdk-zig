const std = @import("std");

pub const ProductionVariantAcceleratorType = enum {
    ml_eia1_medium,
    ml_eia1_large,
    ml_eia1_xlarge,
    ml_eia2_medium,
    ml_eia2_large,
    ml_eia2_xlarge,

    pub const json_field_names = .{
        .ml_eia1_medium = "ml.eia1.medium",
        .ml_eia1_large = "ml.eia1.large",
        .ml_eia1_xlarge = "ml.eia1.xlarge",
        .ml_eia2_medium = "ml.eia2.medium",
        .ml_eia2_large = "ml.eia2.large",
        .ml_eia2_xlarge = "ml.eia2.xlarge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ml_eia1_medium => "ml.eia1.medium",
            .ml_eia1_large => "ml.eia1.large",
            .ml_eia1_xlarge => "ml.eia1.xlarge",
            .ml_eia2_medium => "ml.eia2.medium",
            .ml_eia2_large => "ml.eia2.large",
            .ml_eia2_xlarge => "ml.eia2.xlarge",
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
