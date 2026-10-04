const std = @import("std");

pub const TrainingJobSortByOptions = enum {
    name,
    creation_time,
    status,
    final_objective_metric_value,

    pub const json_field_names = .{
        .name = "Name",
        .creation_time = "CreationTime",
        .status = "Status",
        .final_objective_metric_value = "FinalObjectiveMetricValue",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "Name",
            .creation_time => "CreationTime",
            .status => "Status",
            .final_objective_metric_value => "FinalObjectiveMetricValue",
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
