const std = @import("std");

pub const ResourceGroupByField = enum {
    account_id,
    region,
    resource_category,
    resource_type,
    resource_name,
    finding_type,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .region = "Region",
        .resource_category = "ResourceCategory",
        .resource_type = "ResourceType",
        .resource_name = "ResourceName",
        .finding_type = "FindingsSummary.FindingType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "AccountId",
            .region => "Region",
            .resource_category => "ResourceCategory",
            .resource_type => "ResourceType",
            .resource_name => "ResourceName",
            .finding_type => "FindingsSummary.FindingType",
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
