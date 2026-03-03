const std = @import("std");

pub const DriftType = enum {
    application_compliance,
    app_component_resiliency_compliance_status,

    pub const json_field_names = .{
        .application_compliance = "ApplicationCompliance",
        .app_component_resiliency_compliance_status = "AppComponentResiliencyComplianceStatus",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .application_compliance => "ApplicationCompliance",
            .app_component_resiliency_compliance_status => "AppComponentResiliencyComplianceStatus",
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
