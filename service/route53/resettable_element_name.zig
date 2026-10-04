const std = @import("std");

pub const ResettableElementName = enum {
    fully_qualified_domain_name,
    regions,
    resource_path,
    child_health_checks,

    pub const json_field_names = .{
        .fully_qualified_domain_name = "FullyQualifiedDomainName",
        .regions = "Regions",
        .resource_path = "ResourcePath",
        .child_health_checks = "ChildHealthChecks",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fully_qualified_domain_name => "FullyQualifiedDomainName",
            .regions => "Regions",
            .resource_path => "ResourcePath",
            .child_health_checks => "ChildHealthChecks",
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
