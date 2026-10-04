const std = @import("std");

pub const ActionType = enum {
    iam,
    scp,
    ssm,

    pub const json_field_names = .{
        .iam = "APPLY_IAM_POLICY",
        .scp = "APPLY_SCP_POLICY",
        .ssm = "RUN_SSM_DOCUMENTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam => "APPLY_IAM_POLICY",
            .scp => "APPLY_SCP_POLICY",
            .ssm => "RUN_SSM_DOCUMENTS",
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
