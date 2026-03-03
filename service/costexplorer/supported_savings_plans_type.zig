const std = @import("std");

pub const SupportedSavingsPlansType = enum {
    compute_sp,
    ec2_instance_sp,
    sagemaker_sp,
    database_sp,

    pub const json_field_names = .{
        .compute_sp = "COMPUTE_SP",
        .ec2_instance_sp = "EC2_INSTANCE_SP",
        .sagemaker_sp = "SAGEMAKER_SP",
        .database_sp = "DATABASE_SP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compute_sp => "COMPUTE_SP",
            .ec2_instance_sp => "EC2_INSTANCE_SP",
            .sagemaker_sp => "SAGEMAKER_SP",
            .database_sp => "DATABASE_SP",
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
