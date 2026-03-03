const std = @import("std");

pub const AuthorizationStrategy = enum {
    smartv1,
    smart_on_fhir,
    aws_auth,

    pub const json_field_names = .{
        .smartv1 = "SMART_ON_FHIR_V1",
        .smart_on_fhir = "SMART_ON_FHIR",
        .aws_auth = "AWS_AUTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .smartv1 => "SMART_ON_FHIR_V1",
            .smart_on_fhir => "SMART_ON_FHIR",
            .aws_auth => "AWS_AUTH",
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
