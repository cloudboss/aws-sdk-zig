const std = @import("std");

pub const ResaleAccountModel = enum {
    distributor,
    end_customer,
    solution_provider,

    pub const json_field_names = .{
        .distributor = "DISTRIBUTOR",
        .end_customer = "END_CUSTOMER",
        .solution_provider = "SOLUTION_PROVIDER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .distributor => "DISTRIBUTOR",
            .end_customer => "END_CUSTOMER",
            .solution_provider => "SOLUTION_PROVIDER",
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
