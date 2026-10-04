const std = @import("std");

pub const DatasourcePackage = enum {
    detective_core,
    eks_audit,
    asff_securityhub_finding,

    pub const json_field_names = .{
        .detective_core = "DETECTIVE_CORE",
        .eks_audit = "EKS_AUDIT",
        .asff_securityhub_finding = "ASFF_SECURITYHUB_FINDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .detective_core => "DETECTIVE_CORE",
            .eks_audit => "EKS_AUDIT",
            .asff_securityhub_finding => "ASFF_SECURITYHUB_FINDING",
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
