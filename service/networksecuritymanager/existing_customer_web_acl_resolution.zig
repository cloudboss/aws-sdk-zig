const std = @import("std");

pub const ExistingCustomerWebACLResolution = enum {
    retrofit,
    override_association,
    no_remediation,

    pub const json_field_names = .{
        .retrofit = "RETROFIT",
        .override_association = "OVERRIDE_ASSOCIATION",
        .no_remediation = "NO_REMEDIATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .retrofit => "RETROFIT",
            .override_association => "OVERRIDE_ASSOCIATION",
            .no_remediation => "NO_REMEDIATION",
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
