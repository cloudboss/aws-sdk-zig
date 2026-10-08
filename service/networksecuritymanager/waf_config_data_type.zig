const std = @import("std");

pub const WAFConfigDataType = enum {
    default_action,
    visibility_config,
    captcha_config,
    challenge_config,
    custom_response_bodies,
    logging_configuration,
    data_protection_config,
    association_config,
    on_source_ddos_protection_config,
    token_domains,

    pub const json_field_names = .{
        .default_action = "DefaultAction",
        .visibility_config = "VisibilityConfig",
        .captcha_config = "CaptchaConfig",
        .challenge_config = "ChallengeConfig",
        .custom_response_bodies = "CustomResponseBodies",
        .logging_configuration = "LoggingConfiguration",
        .data_protection_config = "DataProtectionConfig",
        .association_config = "AssociationConfig",
        .on_source_ddos_protection_config = "OnSourceDDoSProtectionConfig",
        .token_domains = "TokenDomains",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default_action => "DefaultAction",
            .visibility_config => "VisibilityConfig",
            .captcha_config => "CaptchaConfig",
            .challenge_config => "ChallengeConfig",
            .custom_response_bodies => "CustomResponseBodies",
            .logging_configuration => "LoggingConfiguration",
            .data_protection_config => "DataProtectionConfig",
            .association_config => "AssociationConfig",
            .on_source_ddos_protection_config => "OnSourceDDoSProtectionConfig",
            .token_domains => "TokenDomains",
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
