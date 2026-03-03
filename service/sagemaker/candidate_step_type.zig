const std = @import("std");

pub const CandidateStepType = enum {
    training,
    transform,
    processing,

    pub const json_field_names = .{
        .training = "AWS::SageMaker::TrainingJob",
        .transform = "AWS::SageMaker::TransformJob",
        .processing = "AWS::SageMaker::ProcessingJob",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .training => "AWS::SageMaker::TrainingJob",
            .transform => "AWS::SageMaker::TransformJob",
            .processing => "AWS::SageMaker::ProcessingJob",
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
