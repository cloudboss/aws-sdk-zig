const std = @import("std");

pub const AutoMLMode = enum {
    auto,
    ensembling,
    hyperparameter_tuning,

    pub const json_field_names = .{
        .auto = "AUTO",
        .ensembling = "ENSEMBLING",
        .hyperparameter_tuning = "HYPERPARAMETER_TUNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .ensembling => "ENSEMBLING",
            .hyperparameter_tuning => "HYPERPARAMETER_TUNING",
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
