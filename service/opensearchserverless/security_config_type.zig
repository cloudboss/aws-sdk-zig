const std = @import("std");

pub const SecurityConfigType = enum {
    /// saml provider
    saml,
    /// iam identity center
    iamidentitycenter,
    /// iam federation
    iamfederation,

    pub const json_field_names = .{
        .saml = "saml",
        .iamidentitycenter = "iamidentitycenter",
        .iamfederation = "iamfederation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .saml => "saml",
            .iamidentitycenter => "iamidentitycenter",
            .iamfederation => "iamfederation",
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
