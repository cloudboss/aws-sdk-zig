const std = @import("std");

pub const OpportunitySortName = enum {
    last_modifieddate,
    identifier,
    customer_company_name,
    created_date,
    target_close_date,

    pub const json_field_names = .{
        .last_modifieddate = "LastModifiedDate",
        .identifier = "Identifier",
        .customer_company_name = "CustomerCompanyName",
        .created_date = "CreatedDate",
        .target_close_date = "TargetCloseDate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .last_modifieddate => "LastModifiedDate",
            .identifier => "Identifier",
            .customer_company_name => "CustomerCompanyName",
            .created_date => "CreatedDate",
            .target_close_date => "TargetCloseDate",
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
