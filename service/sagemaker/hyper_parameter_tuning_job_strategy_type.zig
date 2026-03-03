const std = @import("std");

/// The strategy hyperparameter tuning uses to find the best combination of
/// hyperparameters for your model.
pub const HyperParameterTuningJobStrategyType = enum {
    bayesian,
    random,
    hyperband,
    grid,

    pub const json_field_names = .{
        .bayesian = "Bayesian",
        .random = "Random",
        .hyperband = "Hyperband",
        .grid = "Grid",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bayesian => "Bayesian",
            .random => "Random",
            .hyperband => "Hyperband",
            .grid => "Grid",
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
