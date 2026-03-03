const std = @import("std");

pub const SavingsPlanType = enum {
    compute,
    ec2_instance,
    sagemaker,
    database,

    pub const json_field_names = .{
        .compute = "Compute",
        .ec2_instance = "EC2Instance",
        .sagemaker = "SageMaker",
        .database = "Database",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compute => "Compute",
            .ec2_instance => "EC2Instance",
            .sagemaker => "SageMaker",
            .database => "Database",
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
