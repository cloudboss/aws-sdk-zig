const std = @import("std");

/// Contains the key values of `DetailsMap`:
///
/// * `PredictiveModelType` - Indicates the type of the `MLModel`.
///
/// * `Algorithm` - Indicates the algorithm that was used for the `MLModel`.
pub const DetailsAttributes = enum {
    predictive_model_type,
    algorithm,

    pub const json_field_names = .{
        .predictive_model_type = "PredictiveModelType",
        .algorithm = "Algorithm",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .predictive_model_type => "PredictiveModelType",
            .algorithm => "Algorithm",
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
