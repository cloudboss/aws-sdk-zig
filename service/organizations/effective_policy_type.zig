const std = @import("std");

pub const EffectivePolicyType = enum {
    tag_policy,
    backup_policy,
    aiservices_opt_out_policy,
    chatbot_policy,
    declarative_policy_ec2,
    securityhub_policy,
    inspector_policy,
    upgrade_rollout_policy,
    bedrock_policy,
    s3_policy,
    network_security_director_policy,

    pub const json_field_names = .{
        .tag_policy = "TAG_POLICY",
        .backup_policy = "BACKUP_POLICY",
        .aiservices_opt_out_policy = "AISERVICES_OPT_OUT_POLICY",
        .chatbot_policy = "CHATBOT_POLICY",
        .declarative_policy_ec2 = "DECLARATIVE_POLICY_EC2",
        .securityhub_policy = "SECURITYHUB_POLICY",
        .inspector_policy = "INSPECTOR_POLICY",
        .upgrade_rollout_policy = "UPGRADE_ROLLOUT_POLICY",
        .bedrock_policy = "BEDROCK_POLICY",
        .s3_policy = "S3_POLICY",
        .network_security_director_policy = "NETWORK_SECURITY_DIRECTOR_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tag_policy => "TAG_POLICY",
            .backup_policy => "BACKUP_POLICY",
            .aiservices_opt_out_policy => "AISERVICES_OPT_OUT_POLICY",
            .chatbot_policy => "CHATBOT_POLICY",
            .declarative_policy_ec2 => "DECLARATIVE_POLICY_EC2",
            .securityhub_policy => "SECURITYHUB_POLICY",
            .inspector_policy => "INSPECTOR_POLICY",
            .upgrade_rollout_policy => "UPGRADE_ROLLOUT_POLICY",
            .bedrock_policy => "BEDROCK_POLICY",
            .s3_policy => "S3_POLICY",
            .network_security_director_policy => "NETWORK_SECURITY_DIRECTOR_POLICY",
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
