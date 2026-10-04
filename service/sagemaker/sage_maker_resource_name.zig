const std = @import("std");

pub const SageMakerResourceName = enum {
    training_job,
    hyperpod_cluster,
    endpoint,
    studio_apps,

    pub const json_field_names = .{
        .training_job = "training-job",
        .hyperpod_cluster = "hyperpod-cluster",
        .endpoint = "endpoint",
        .studio_apps = "studio-apps",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .training_job => "training-job",
            .hyperpod_cluster => "hyperpod-cluster",
            .endpoint => "endpoint",
            .studio_apps => "studio-apps",
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
