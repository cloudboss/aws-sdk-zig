const std = @import("std");

pub const SageMakerResourceName = enum {
    training_job,
    hyperpod_cluster,
    endpoint,

    pub const json_field_names = .{
        .training_job = "training-job",
        .hyperpod_cluster = "hyperpod-cluster",
        .endpoint = "endpoint",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .training_job => "training-job",
            .hyperpod_cluster => "hyperpod-cluster",
            .endpoint => "endpoint",
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
