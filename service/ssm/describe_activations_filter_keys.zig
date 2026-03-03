const std = @import("std");

pub const DescribeActivationsFilterKeys = enum {
    activation_ids,
    default_instance_name,
    iam_role,

    pub const json_field_names = .{
        .activation_ids = "ActivationIds",
        .default_instance_name = "DefaultInstanceName",
        .iam_role = "IamRole",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activation_ids => "ActivationIds",
            .default_instance_name => "DefaultInstanceName",
            .iam_role => "IamRole",
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
