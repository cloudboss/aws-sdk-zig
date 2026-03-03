const std = @import("std");

pub const LaunchTemplateErrorCode = enum {
    launch_template_id_does_not_exist,
    launch_template_id_malformed,
    launch_template_name_does_not_exist,
    launch_template_name_malformed,
    launch_template_version_does_not_exist,
    unexpected_error,

    pub const json_field_names = .{
        .launch_template_id_does_not_exist = "launchTemplateIdDoesNotExist",
        .launch_template_id_malformed = "launchTemplateIdMalformed",
        .launch_template_name_does_not_exist = "launchTemplateNameDoesNotExist",
        .launch_template_name_malformed = "launchTemplateNameMalformed",
        .launch_template_version_does_not_exist = "launchTemplateVersionDoesNotExist",
        .unexpected_error = "unexpectedError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .launch_template_id_does_not_exist => "launchTemplateIdDoesNotExist",
            .launch_template_id_malformed => "launchTemplateIdMalformed",
            .launch_template_name_does_not_exist => "launchTemplateNameDoesNotExist",
            .launch_template_name_malformed => "launchTemplateNameMalformed",
            .launch_template_version_does_not_exist => "launchTemplateVersionDoesNotExist",
            .unexpected_error => "unexpectedError",
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
