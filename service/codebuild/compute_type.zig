const std = @import("std");

pub const ComputeType = enum {
    build_general1_small,
    build_general1_medium,
    build_general1_large,
    build_general1_xlarge,
    build_general1_2_xlarge,
    build_lambda_1_gb,
    build_lambda_2_gb,
    build_lambda_4_gb,
    build_lambda_8_gb,
    build_lambda_10_gb,
    attribute_based_compute,
    custom_instance_type,

    pub const json_field_names = .{
        .build_general1_small = "BUILD_GENERAL1_SMALL",
        .build_general1_medium = "BUILD_GENERAL1_MEDIUM",
        .build_general1_large = "BUILD_GENERAL1_LARGE",
        .build_general1_xlarge = "BUILD_GENERAL1_XLARGE",
        .build_general1_2_xlarge = "BUILD_GENERAL1_2XLARGE",
        .build_lambda_1_gb = "BUILD_LAMBDA_1GB",
        .build_lambda_2_gb = "BUILD_LAMBDA_2GB",
        .build_lambda_4_gb = "BUILD_LAMBDA_4GB",
        .build_lambda_8_gb = "BUILD_LAMBDA_8GB",
        .build_lambda_10_gb = "BUILD_LAMBDA_10GB",
        .attribute_based_compute = "ATTRIBUTE_BASED_COMPUTE",
        .custom_instance_type = "CUSTOM_INSTANCE_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .build_general1_small => "BUILD_GENERAL1_SMALL",
            .build_general1_medium => "BUILD_GENERAL1_MEDIUM",
            .build_general1_large => "BUILD_GENERAL1_LARGE",
            .build_general1_xlarge => "BUILD_GENERAL1_XLARGE",
            .build_general1_2_xlarge => "BUILD_GENERAL1_2XLARGE",
            .build_lambda_1_gb => "BUILD_LAMBDA_1GB",
            .build_lambda_2_gb => "BUILD_LAMBDA_2GB",
            .build_lambda_4_gb => "BUILD_LAMBDA_4GB",
            .build_lambda_8_gb => "BUILD_LAMBDA_8GB",
            .build_lambda_10_gb => "BUILD_LAMBDA_10GB",
            .attribute_based_compute => "ATTRIBUTE_BASED_COMPUTE",
            .custom_instance_type => "CUSTOM_INSTANCE_TYPE",
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
