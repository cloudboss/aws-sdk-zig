const std = @import("std");

pub const ComputePlatform = enum {
    /// Compute platform meant to used for all usecases (like EC2, Fargate, physical
    /// servers etc.) but AWS Lambda.
    default,
    /// Compute platform meant to used for AWS Lambda.
    awslambda,

    pub const json_field_names = .{
        .default = "Default",
        .awslambda = "AWSLambda",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "Default",
            .awslambda => "AWSLambda",
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
