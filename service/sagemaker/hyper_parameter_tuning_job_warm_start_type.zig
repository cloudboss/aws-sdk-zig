const std = @import("std");

pub const HyperParameterTuningJobWarmStartType = enum {
    identical_data_and_algorithm,
    transfer_learning,

    pub const json_field_names = .{
        .identical_data_and_algorithm = "IdenticalDataAndAlgorithm",
        .transfer_learning = "TransferLearning",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identical_data_and_algorithm => "IdenticalDataAndAlgorithm",
            .transfer_learning => "TransferLearning",
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
