const std = @import("std");

pub const ImageConfigurationStep = enum {
    associate_licenses,
    update_launch_templates,
    put_ssm_parameters,
    update_fast_launch_configurations,
    export_ami,

    pub const json_field_names = .{
        .associate_licenses = "ASSOCIATE_LICENSES",
        .update_launch_templates = "UPDATE_LAUNCH_TEMPLATES",
        .put_ssm_parameters = "PUT_SSM_PARAMETERS",
        .update_fast_launch_configurations = "UPDATE_FAST_LAUNCH_CONFIGURATIONS",
        .export_ami = "EXPORT_AMI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associate_licenses => "ASSOCIATE_LICENSES",
            .update_launch_templates => "UPDATE_LAUNCH_TEMPLATES",
            .put_ssm_parameters => "PUT_SSM_PARAMETERS",
            .update_fast_launch_configurations => "UPDATE_FAST_LAUNCH_CONFIGURATIONS",
            .export_ami => "EXPORT_AMI",
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
